Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968FE2222D1;
	Mon, 17 Feb 2025 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739803743; cv=pass; b=qi6ffWYND8zfh1/o1Tp6LDUhd4PI6KFV97zniC2jIas7+r04CHiJUPkN7lCtY7BeCmN1Phi6Pz819E9PdWJyWF9NArGjWuDON42BdGwNhjvsT9YfrEAWnNhii3IMX+6L/Mm23etHCLpFxeNEkR2o5OJlV8SuMWpnh7DfnNvYwXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739803743; c=relaxed/simple;
	bh=A/Od5TUwsJhA8mx1EQWCsKiLy7LSZWLxOCZEMDPYq5s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pySjLEYkjv4g2g9c4+Nvn0X6b6elK43317kWvYx7ght5iPltcYowAzABAi0GbpWrx8BJt2Y1DRLAWQGG27VYXdqrDnEsp7lcNIS0NEJbJbt/baW4u7VuU2rlHACYt/YX3sSzTZwM68oiILhD2DLaCBtNpEZ60D80xgo5ROqRvpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=AvVaxsCp; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="AvVaxsCp"
ARC-Seal: i=1; a=rsa-sha256; t=1739803723; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kFwAbnouE55WH7Hd9qMl4e+ZJt5V8YNf4O7eWIiCP6RWDeufhFXPXk9pOSV7uXmElyCdccFbH7Bk9c5pvzjMfaNv6Ktd7/JUZ0hEMtcfZHuui2P/mHWYH0qnDHhraEcOkz9aIDSOvVqt5Ox4htjUciS97TZhLlm8kphRLq3cwvw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739803723; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ycDqgIL5ICKkCtR/gqGg8lD2i2dQ//1wJagDW0VlWnY=; 
	b=gJ8YEQKC+uXwyR0Vhd91ARWlUutheBOLuxUtyy2D5/u1NnXxktyVaxTaXw2oqtZSnu0y06wnPQxo0DxXjgbR7oahtNZ8Q3q1YOCdd/st7q6nFRZdf3Qq63DDqOE+TEbK26EmeAEAUwJiihwVa+ADIrNjWOnqhv8m9eklcqKA7L8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739803723;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=ycDqgIL5ICKkCtR/gqGg8lD2i2dQ//1wJagDW0VlWnY=;
	b=AvVaxsCprakUNa8LDYcoznshpridrEdLfRU5AsfV08T3T1Y+MDsZfvNUGIiBQp72
	GdZQ0wBu9QmeWZ/ckhdI4DjHMLU/tw0kmBL2dy8wLcOzefijO749GY3xYqrerbnD0UZ
	biPJB0xMnKvnLuz1sd5N3Y0oTDdNs6UoAjtcrNqg=
Received: by mx.zohomail.com with SMTPS id 1739803720959126.8844032888727;
	Mon, 17 Feb 2025 06:48:40 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v2 0/7] Use guard() instead of rwsem locking
Date: Mon, 17 Feb 2025 22:48:21 +0800
Message-Id: <20250217144828.30651-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122798fd5753cde6f4ada8ba69df000067950776227fe6eefd44525e66f86efe9ff6faebccaf59f683:zu08011227e631806f9df9ff8a80c5e70c0000989082e06bb9497aa87caf93156d890a42670b0627c5c029ae:rf0801122d9ca41d22dfc2cd26847cdd9600009190e2849bc57d39899975caacecdfe26d397fb904456c934a5391abecbc80:ZohoMail
X-ZohoMailClient: External

Use scoped resource management to replace open-coded locking operation
is recommended. CXL subsystem still remains some down_read()/up_read()
and down_write()/up_write() which can be replaced by guard() simply.

This patchset includes simply using guard() instead of some
down_read()/up_read() and down_write()/up_write() cases. Besides, it
also includes some function code cleanup after using guard().

base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3 (tag: v6.14-rc2)

v2:
- Drop some local variables. (Jonathan)
- Rename __construct_region() to construct_auto_region(). (Jonathan and Dave)

Li Ming (7):
  cxl/core: Use guard() to replace open-coded down_read/write()
  cxl/core: cxl_mem_sanitize() cleanup
  cxl/memdev: cxl_memdev_ioctl() cleanup
  cxl/core: Use guard() to drop the goto pattern of cxl_dpa_free()
  cxl/core: Use guard() to drop goto pattern of cxl_dpa_alloc()
  cxl/region: Drop goto pattern in cxl_dax_region_alloc()
  cxl/region: Drop goto pattern of construct_region()

 drivers/cxl/core/hdm.c    | 68 +++++++++++-----------------
 drivers/cxl/core/mbox.c   | 10 ++---
 drivers/cxl/core/memdev.c | 17 +++----
 drivers/cxl/core/port.c   |  8 +---
 drivers/cxl/core/region.c | 95 +++++++++++++++++++--------------------
 5 files changed, 85 insertions(+), 113 deletions(-)

-- 
2.34.1

