"""add overtime_loss_pts and update scoring defaults

Revision ID: a1b2c3d4e5f6
Revises: 5a207d9d1f5a
Create Date: 2026-03-12 23:15:00.000000

"""
from typing import Sequence, Union
from alembic import op
import sqlalchemy as sa

revision: str = 'a1b2c3d4e5f6'
down_revision: Union[str, None] = '5a207d9d1f5a'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # Add overtime_loss_pts column
    op.add_column('scoring_settings',
        sa.Column('overtime_loss_pts', sa.Float(), nullable=True, server_default='1.0')
    )

    # Update existing rows to new default scoring values
    op.execute("""
        UPDATE scoring_settings SET
            goal_pts          = 2.0,
            assist_pts        = 1.0,
            plus_minus_pts    = 0.0,
            pim_pts           = 0.0,
            shot_pts          = 0.1,
            goalie_win_pts    = 4.0,
            goals_against_pts = -2.0,
            overtime_loss_pts = 1.0
    """)


def downgrade() -> None:
    op.drop_column('scoring_settings', 'overtime_loss_pts')

    op.execute("""
        UPDATE scoring_settings SET
            goal_pts          = 3.0,
            assist_pts        = 2.0,
            plus_minus_pts    = 1.0,
            pim_pts           = -0.5,
            shot_pts          = 0.3,
            goalie_win_pts    = 5.0,
            goals_against_pts = -1.0
    """)
