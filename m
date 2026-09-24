Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46EE3BB115;
	Thu, 24 Sep 2026 03:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790221176; cv=none; b=gVLZ8i81lvtSfrQHwngqlcz+YXzR8XGrby2oYMpHkLcf3MkypNxTkBZtuavmMMB0Km7xSRJjyGZFhtPeTPfCcMF5qJZElkhe8iCOKDc8C+uIf5SiAy1HMoumhIxLVZPxBN2DMfmkoy30Os0BB4013ggMr5OZACzjq55dYXrqFZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790221176; c=relaxed/simple;
	bh=VqK+6laanjrz1rxv2yQMX25No3H4+MG+ucA252qDvnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TrBrnndWqIYt5wZlzMK9PeiaPqKAC+ol5WcqktrVlTrqWHMQJfSjE0MXrdrwMX9/5hhLpePL5hzHYFAEtQ34osvP1UzW85U6uft68RHG8glLOj/9XfzbYkZ7F8W8Jrmf6k++g1N+GJ3SZYF3OjCsWOT+BEXm3LWIHfQKW1kcqU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tz34fzE5; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tz34fzE5"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790221169; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=x5UQzPD0SWBkAXpHucjkoYsBGLd0sRwE9DOzhDz+9zw=;
	b=tz34fzE5djs3wmU2KlX9zBP/HfqYIGn7UxRCLewVT33WIhGxu7yRAz9Rkd4/Vv4AoZNU/XaWvocPdjcZt36O+RG9LzAmUPZDBuOiyuKUkym2wr5i6RhX97XLXQuHRTTQjEMf3mMuJZrUdvJlcD1g5Uwj+jsnY7963hHa1Kgzg6Y=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0XBYNdiX_1790221168;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XBYNdiX_1790221168 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Sep 2026 11:39:29 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: [PATCH v2] checkpatch: don't flag ACQUIRE_ERR() assignments in if conditions
Date: Thu, 24 Sep 2026 11:39:23 +0800
Message-ID: <20260924033923.4140210-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACQUIRE_ERR() and its wrappers, PM_RUNTIME_ACQUIRE_ERR() and
IIO_DEV_ACQUIRE_FAILED(), report whether a conditional cleanup.h guard
was acquired, and drivers consume the result directly in an if
condition:

	if ((rc = ACQUIRE_ERR(mutex_intr, &lock)))
		return rc;

That combined form is the established style at the 49 in-tree call
sites under drivers/cxl and drivers/pci/tsm.c, so ASSIGN_IN_IF fires
there only as a false positive, and every patch touching those lines
carries noise that reviewers have to wave off manually.

Skip the check only when every assignment in the condition assigns the
result of such a call, matched by the *_ACQUIRE_ERR() /
*_ACQUIRE_FAILED() naming convention of its wrappers. Plain
assignments, mixed conditions and near-miss identifiers still get
flagged.

Suggested-by: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

---
Changes since v1 [1]:

- Check each assignment in the condition instead of the condition as a
  whole, so a mixed condition such as
  "if ((rc = regular_function()) || (ret = ACQUIRE_ERR(...)))" keeps
  getting flagged (Alison Schofield).
- Match the assigned-to expression with $Lval, as Joe Perches
  suggested on Alison's earlier attempt at this exception [2].
- Cc linux-cxl, where most users of this form live.

Two deviations from [2]: the assigned expression capture excludes '=',
so an '==' comparison in a mixed condition is not mistaken for a bad
assignment, and the check requires an assignment the $Lval match can
see, so compound assignments like '+=', which it cannot see, are not
silently allowed.

Testing: ran checkpatch on a test file with the allowed forms (bare
macro and both wrappers, member and array element lhs, multiple
ACQUIRE family assignments in one condition, an '==' comparison
alongside, no spaces around '=') and with 14 cases that must still
trigger (plain assignments, near-miss identifiers, arithmetic on the
call result, ACQUIRE_ERR in a comment, indirect assignment, mixed
conditions in both orders). All allowed forms pass, all 14 still
trigger. The 49 in-tree call sites under drivers/cxl and
drivers/pci/tsm.c no longer report ASSIGN_IN_IF, and checkpatch output
is unchanged for fs/namei.c, kernel/sched/core.c, mm/vmscan.c and
net/core/dev.c.

[1] https://lore.kernel.org/all/20260916020921.3480730-1-kanie@linux.alibaba.com/
[2] https://lore.kernel.org/linux-cxl/20250815010645.2980846-1-alison.schofield@intel.com/
---
 scripts/checkpatch.pl | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 8a7787d228a6..eee06ac6737f 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5777,7 +5777,21 @@ sub process {
 			my ($s, $c) = ($stat, $cond);
 			my $fixed_assign_in_if = 0;
 
+			# ACQUIRE_ERR() and its wrappers, e.g. PM_RUNTIME_ACQUIRE_ERR()
+			# and IIO_DEV_ACQUIRE_FAILED(), are meant to be evaluated in an
+			# if condition, with the error assigned in the condition:
+			#	if ((rc = ACQUIRE_ERR(name, &lock)))
+			# Allow that only when every assignment in the condition assigns
+			# the result of such a call, so that a mixed condition keeps
+			# getting flagged:
+			#	if ((rc = regular_function()) || (ret = ACQUIRE_ERR(name, &lock)))
+			my $assign_in_if = 0;
 			if ($c =~ /\bif\s*\(.*[^<>!=]=[^=].*/s) {
+				my $has_assignment = $c =~ /\b$Lval\s*=\s*[^,)&|=]+/;
+				my $has_other_assignment = $c =~ /\b$Lval\s*=\s*(?!\s*\w*ACQUIRE_(?:ERR|FAILED)\s*\()[^,)&|=]+/;
+				$assign_in_if = !$has_assignment || $has_other_assignment;
+			}
+			if ($assign_in_if) {
 				if (ERROR("ASSIGN_IN_IF",
 					  "do not use assignment in if condition\n" . $herecurr) &&
 				    $fix && $perl_version_ok) {
-- 
2.43.7

