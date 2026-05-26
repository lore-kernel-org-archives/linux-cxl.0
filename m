Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC1E3DE452
	for <linux-cxl@vger.kernel.org>; Tue, 26 May 2026 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801792; cv=none; b=opV5GGerVGMalsdD8oureqTo1r0N1E5PPMAFlWGU8ffceU1e7rq2VoRtbxWdXvCMhmx8SVBAS1BmvEDEw8rHAKgX0jGR3idHDqWu/ih9TOH/Kd441jGJ7OHrFv2Hc1OxBEGcPL6hHryBtERu/8RG3NeGMavMaCCidIcgc2Pmdpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801792; c=relaxed/simple;
	bh=KRaJ2Lr1FqzZRdLMgsmyXLcTV8G1AW/a8QJoeMWZVC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D6M4zudAOOQIUZsPA16+2ELd5uSfXDFmX5RqArmA8gYSHp5swG6cvVWJU64VhdQA/k4iuRqA8ZQ0T/K7sh5BuMnShu8Fo4yM85WPV2IaA0dF92G6YfNZOYMF6ohVKTUkV3stcACBWkBLRw0KtUcFr7vXLwh++KSIcPvghxLCefI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZloIX2GY; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZloIX2GY"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779801787; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=YVKPOZZ4vW5hg7XXNIilnNwn5NwCxCP/lWTpZKzg60g=;
	b=ZloIX2GYbzjsdT7/CUR06Ewsfb+DOLth/4Guc/i1UA38kfBvoFXGwuENLASWG3cqKtd624lgBXBzHOK71qKwJulDBAEfDVP1raclnWzk6mymLcoSGEamGYR5uad5uJA5BPTXJp+ZNBUS+6T01Ojuzp6/2vsbzIX2bN+xKET1EbY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X3gT8lT_1779801777;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X3gT8lT_1779801777 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 May 2026 21:23:06 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: alison.schofield@intel.com,
	dave.jiang@intel.com,
	jic23@kernel.org,
	nvdimm@lists.linux.dev
Cc: linux-cxl@vger.kernel.org,
	guoren@kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [ndctl PATCH v2 0/2] daxctl, util/sysfs: fix builtin-driver false failure on enable
Date: Tue, 26 May 2026 21:22:49 +0800
Message-ID: <20260526132251.254476-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a DAX / ndctl driver is builtin (not a loadable module),
daxctl_insert_kmod_for_mode() and __util_bind() still call
kmod_module_probe_insert_module() unconditionally. libkmod only
short-circuits builtin modules when it can find the modules.builtin
index; otherwise it falls through to init_module() and returns -ENOENT,
surfacing as a spurious "insert failure".

Pre-check kmod_module_get_initstate() and skip probe-insert when the
module is already BUILTIN or LIVE, matching the pattern used by ndctl's
own test/core.c.

Changes since v1 [1]:
  - Patch 1/2 unchanged; collected Reviewed-by from Dave and Alison.
  - Patch 2/2: factored the state check into a new helper
    util_kmod_skip_probe_insert() in util/sysfs.{c,h} so both
    daxctl_insert_kmod_for_mode() and __util_bind() share it. The
    helper also returns the observed libkmod state via an out
    parameter so the caller does not re-read /sys/module/<name>/
    initstate to distinguish LIVE from BUILTIN.
  - Patch 2/2: additionally treat KMOD_MODULE_COMING as builtin when
    /sys/module/<name>/ exists but the initstate file does not. This
    is the pattern libkmod's sysfs fallback emits for builtin drivers
    when the modules.builtin index is missing (e.g. a kernel installed
    without running modules_install). This was the case Jonathan hit
    on a builtin DAX VM setup; rather than rely on a libkmod fix, ndctl
    handles the corner case directly. Suggested by Alison [2].

[1]: https://lore.kernel.org/nvdimm/20260514063234.86439-1-cp0613@linux.alibaba.com/
[2]: https://lore.kernel.org/nvdimm/agtf5uwBJOaCDR6l@aschofie-mobl2.lan/

Chen Pei (2):
  daxctl: fix kmod reference leak on probe-insert failure
  daxctl, util/sysfs: skip module probe-insert when driver is builtin or
    live

 daxctl/lib/libdaxctl.c | 23 ++++++++++++++++++++--
 util/sysfs.c           | 44 +++++++++++++++++++++++++++++++++++++++++-
 util/sysfs.h           | 16 +++++++++++++++
 3 files changed, 80 insertions(+), 3 deletions(-)

-- 
2.50.1

