Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA81570814;
	Fri, 11 Jul 2025 03:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752203495; cv=pass; b=ikVHlszBYLDDyU1PWD5qrua4IdN++f1Bfg0pUM3ZCpEyDL07xs+odNh7PMr5ZezIVujp/9AvtnWDTnNqhB88y2gC4Qdai6H4G1e0KTxk9N+SbxoTmQ5/UJv27LjMMojVEdzRatX3W9tMVRyNySmY3mcnl1C6wyN2WXM/vTtkduk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752203495; c=relaxed/simple;
	bh=9lA6AsDSIKoY0lUH2t1x8CvthtWRQbyzxeeFVTUETPE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tTVUI2g8Dxtnu9w4iCmAmF/Un1KTQYYJEOfleUsZh5e4gzqhsDdeoNgPJpQuDmpJ3KA/tSnc780v50iQZbQCAilDXBK9NDJp5PqJ44xXuzES2XKMl+W+8JhXOCenm3j+Lnv8e6F7xiKYnN1krDtN/ve76Z2b7JKUk6kPt5VCa9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=dysiy+LB; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="dysiy+LB"
ARC-Seal: i=1; a=rsa-sha256; t=1752203481; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TUmw7DUiH37TUzbJZUND3bPrFx+b6TtqdDCRdTJVxvJOQQH2PiNGjVHr5jAHoVGdq/eAV+K3eUQWo//D0TnuvYgIaOX6KMhPsSHkTHwMWS0F0QBofhdfHQWuJJi9FgDNONRbuZk7IubUixfgJLgKxSmqBNBqz1XkaeMXH8Odgb4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752203481; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Zmlfr2FfNR3ElW19AW0PAO2HPIGKZykTu782CJfTIAI=; 
	b=KItq8jej1R/usMNPYIKnuxozw6E8zBzNlbGqZiajvPB6H+L8zU4L8cVhKx3OhZoPt21IHEbRUNUi4B1z9HZYHs+/91BU2rxCqTKpmFb0P47RJfbL9OtrrWj7jn5NEfsN4PECypN8j3yVlih0PQv/kq5dOJJ9qpoq+phJmgWYZWI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752203481;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=Zmlfr2FfNR3ElW19AW0PAO2HPIGKZykTu782CJfTIAI=;
	b=dysiy+LBR+Jn9y262JjqTeCKB15IYs7H/iEmYPh7Zx8rObI5xXtWETIhJZAankuj
	EAoyNDFSWxHIlqvMcMg1FuvXgajTN6IKYO+ZS+zJ5yH5ATH2BLUBaw3zBYQ2FiII7KL
	vKND5qINUueQZILMIUkx83h+2F0d9Ze3x41ddrX0=
Received: by mx.zohomail.com with SMTPS id 1752203480377746.5900346950284;
	Thu, 10 Jul 2025 20:11:20 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	shiju.jose@huawei.com
Cc: andriy.shevchenko@linux.intel.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v5 0/3] Fix wrong dpa checking in PPR operation
Date: Fri, 11 Jul 2025 11:10:58 +0800
Message-Id: <20250711031101.126990-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227c8c1f03f40a52119ceb8d9b4000003826e9c5c8b77023a5662a40023ce6ea3dcd6a747ac4487a9:zu0801122744dd0033f514a92266e07ea7000039188ea2cf23c809780a2a2e3ecb56e7d75afa06f4902f7e6e:rf0801122d8a10e8271e3c55d0bd048ec60000a0c6565678dac7ffe55d0b59cca69f6300adfd3384ce7bd98f24e324c63da3:ZohoMail
X-ZohoMailClient: External

In cxl_do_ppr(), there is a checking to check if a DPA is valid, the
implementation of the checking is check if the DPA is 0, if yes,
consider that DPA is valid. the checking is not right, the correct
implementation is checking if the DPA is in the CXL device DPA range, if
yes, it is valid.

The patchset also includes another part implementing a general helper
function cxl_resource_contains_addr() in cxl core so that cxl drivers
can use it for all DPA/HPA/SPA availability checking.

v5:
- Reverse checkings order in cxl_do_ppr(). (Alison)

v4:
- Add cxl_ prefix to resource_contains_addr().	(Andy & Alison)
- Add impact statement to the commit log of Patch #2. (Alison)
- Add review tags.

v3:
- Move resource_contains_addr() from include/linux/ioport.h to
cxl/core/hdm.c. (Andy)

v2:
- Implement a general helper resource_contains_addr() for DPA/HPA
resource. (Alison)

base-commit: d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af cxl/fixes

Li Ming (3):
  cxl/core: Introduce a new helper cxl_resource_contains_addr()
  cxl/edac: Fix wrong dpa checking for PPR operation
  cxl/core: Using cxl_resource_contains_addr() to check address
    availability

 drivers/cxl/core/core.h   | 1 +
 drivers/cxl/core/edac.c   | 9 ++++++---
 drivers/cxl/core/hdm.c    | 7 +++++++
 drivers/cxl/core/memdev.c | 2 +-
 drivers/cxl/core/region.c | 6 +++---
 5 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.34.1

