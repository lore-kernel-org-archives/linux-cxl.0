Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737CE33991;
	Wed, 19 Mar 2025 03:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742356688; cv=pass; b=Gd4AQmR4Sm7XzThVxXAzGZaNAxAVZkg7jaQk/Sw7lCr6i9+SWI/IwMM6RELotxP2tQ4ljdOvTpzKj+blotj3fzZ4wtWnWWd+FlsB+jmVFNJJkQAlN7zpJ3FLAqWG/MH51ectVYVwmsfQLqYJIXBrcNYiGYnl38/dHZWxLs7+5SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742356688; c=relaxed/simple;
	bh=nCYdQ3OK7dwS1vzXCTdkhFjQhg9DVRj6RSXsG7bwfIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PXYOXdHsvYEjAkSKCUP1NmS7VuMyfG5Vo7Ii08qIoYkNZYMLLnCN9qkxtOtw1sw7/nUuz1MTkif3424qnfOr66+hRkihJyRHtluLfijbbuAu30neLW8OiuFDfu2XTzMGntjooZhzXyo1nffCYGvxFj8xFvbzjjAzyYObASFPy/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=WndwIrB1; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="WndwIrB1"
ARC-Seal: i=1; a=rsa-sha256; t=1742356670; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S+dK5i6S/qLQAkY8GLmMuARSmzP1++0MHDHWGILkXXImNzFBQo/08+osv3hYf4VD6Tyev6fgih3v4iz/C+VwesukoCOcXqHGHReaIs+l966nCg3jqWsr70cWDze8Ow1Iz1hIfgSlvimLGn726Pdt3wdvXDtQXyStC2KwzyedejQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742356670; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Mu2FlneNcLf3+mGWdLPBxx5drj7nJaq3F8otrYclUrA=; 
	b=Zm3N9GebKquG4npn+JRntGGMz3XyO03M73KOVeYEfhJKED1XbzD5ZQHV+3pDKAfyUxviAdtMNz3pU6IklBxy5fEep2UQmKv6EwC0UQ28Xj/gUf18N9QlB3KxuEegjhaE232xhDA0IokQ2+tRlMgLahcFdSuAk2LjxwLiNBoM1q8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742356670;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=Mu2FlneNcLf3+mGWdLPBxx5drj7nJaq3F8otrYclUrA=;
	b=WndwIrB18H1MC5HYZ53OOvIoHlIYDIe88bR2fcu7dMMo++wmagINI2d0bvbdcxzl
	PWWECWPneEMbhHQPNDfLGT+wHKplh8Ij8Q+DULP7dgUT39Eh8jCqlttJvpenXPnEG/Q
	xlsgOsI9GqrgL6ljezRUMcMjKMiy+1rMYzwp64ZM=
Received: by mx.zohomail.com with SMTPS id 1742356666740515.2372604787719;
	Tue, 18 Mar 2025 20:57:46 -0700 (PDT)
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
Subject: [RFC Patch v1 0/3] Fix using wrong GPF DVSEC location issue
Date: Wed, 19 Mar 2025 11:55:13 +0800
Message-Id: <20250319035516.222054-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr0801122774fc70a11a6fadc0b864a3970000db64a04291f543a4a7e95b8892d88743df8573d08fe1061ab8:zu08011227eb2bc831c9fa5dfa30fb1ad40000d97d15e1c5a61b0884b2108982310261f1a4faa199a9ee3d7c:rf0801122dfad98893f74f488e1337ed4e00005a3d1a4315b4a3bba1596b8e9da3485716426c863be7e3a1eaecbd4c75a04e:ZohoMail
X-ZohoMailClient: External

During review all new patches in branch cxl/next. I noticed there may be
a problem in below commit.

commit a52b6a2c1c99 ("cxl/pci: Support Global Persistent Flush (GPF)")

There is a new field gpf_dvsec in struct cxl_port to cache GPF DVSEC for
Port(DVSEC ID 04h) location. When the first EP attaching to a cxl port,
it will trigger locating GPF DVSEC on the cxl dport which the first EP
is under, then the location is cached in port->gpf_dvsec. So if another
EP under another dport is attaching, it will reuse the value of
port->gpf_dvsec as GPF DVSEC location for this another dport. The
problem is the cached location may be a wrong location for other dports
of the port.

Per Table 8-2 in CXL r3.2 section 8.1.1 and CXL r3.2 section 8.1.6, Each
CXL Downstream switch ports and CXL root ports have their own GPF DVSEC
for Port(DVSEC ID 04h). So my understanding is that CXL subsystem should
locate GPF DVSEC for Port for each dport rather than using the cached
location in CXL port.

But I am not sure if all dports under a same port will have same
configuration space layout, if yes, that will not be a problem. If I am
wrong, please let me know, thanks.

base-commit: 3b5d43245f0a56390baaa670e1b6d898772266b3 cxl/next

Li Ming (3):
  cxl/core: Fix caching dport GPF DVSEC issue
  cxl/pci: Update Port GPF timeout only when the first EP attaching
  cxl/pci: Drop the parameter is_port of cxl_gpf_get_dvsec()

 drivers/cxl/core/core.h |  2 +-
 drivers/cxl/core/pci.c  | 27 ++++++++++++++++-----------
 drivers/cxl/core/port.c |  2 +-
 drivers/cxl/cxl.h       |  6 +++---
 drivers/cxl/pmem.c      |  2 +-
 5 files changed, 22 insertions(+), 17 deletions(-)

-- 
2.34.1

