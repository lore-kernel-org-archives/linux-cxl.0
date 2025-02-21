Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A08A94A;
	Fri, 21 Feb 2025 01:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101122; cv=pass; b=V1FfayWdTWUg1Xdgetn8AgLlBUifBu67QCM3zm/malM1BHzf8EE7BiX8UNdHTh+bI/35+ptP4oZ7IQsU4gezwwe0XVIo7F+feRRSRWkHXEGnhSlksl2okEUr9rSNUrFL0yIDWcObYWeMKuGXqUJu8/HI32POoaZoOzSpXccYLFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101122; c=relaxed/simple;
	bh=eNUTd8Pwzb3sn5VVhU3MSR+Ke2+8hIHGFLojbK58YKA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o5wLyluG1nQlfhfnlmsnoBrSJstKxRva9TSuqRi6IfBcZ3QtYB0IP1F/vQ/SHxrgiW6zDro41U8nWOnn+RhFoFzOhNOOJYv77WR1/kUhaUssKGkyXbHP2ULCu1c7VFPOZyEINMBmG8p+zW0TofWBezIBd2yEdtxL/OsV9iHWZKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=UDml5skd; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="UDml5skd"
ARC-Seal: i=1; a=rsa-sha256; t=1740101110; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=O6r8OyAPdXn+JfMP+MnkCpcEdIM6XLSrqEW/C8iMFhsULYKQnXfmMoCb67UBEGTIx26bWG7kFcHLrRXv6lsYtBQyZLYKAoGwPQ8xTN4NcxnltzMYShiHhuDZxlLvXssh4B5+KsrjxOJvC4gAqSP1fjLCyT6x6cIOk5kmW8GsyZ0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740101110; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/j4OkYmscxCFB0QUe5C87DI9V9j9fvgPJ8IS7vWSLZw=; 
	b=GIKKKT5dd8hJsc976jiPtKCpHoP+j5UXOg+axeqSQKpOSwLb4EFmiM4J6bSkjCzyaox4zM9i6VKoC4TnkoJQBLtM3JUJQVETHfVhfqt4NjJAXGDoJf0MM7iLDXvkzpJo7iYwOPNs3GpnhpYKbmakgoPgDyPR0QZupORtApc3MEQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740101110;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=/j4OkYmscxCFB0QUe5C87DI9V9j9fvgPJ8IS7vWSLZw=;
	b=UDml5skd7KpCiJSz9TB7lstsx829p2hRt+30aQ5k3uQeDfHVY//wDiEVmZ7WmtjX
	LCw1TIZl0g+XI8Yd5e+Tk4jMA6xCmDrbSDxF8HHHC9103z7HsgfaQ/7Xqf/12aVpl8X
	sFKvB68Gnj+co8b5bI97oGE3ZR9bR9aU8vJOSzb0=
Received: by mx.zohomail.com with SMTPS id 1740101106960820.4420070008008;
	Thu, 20 Feb 2025 17:25:06 -0800 (PST)
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
Subject: [PATCH v3 0/7] Use guard() instead of rwsem locking
Date: Fri, 21 Feb 2025 09:24:46 +0800
Message-Id: <20250221012453.126366-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112279f0406650a0ae653a4af6c1e0000923fa20bb1042050e3c8c30a8f7d23a1fd8125769104c2ca00:zu08011227d79da306d0f2b9dfbd1def980000e5325c699dbc4bbb88fefb3f7920c39cfc0490c2ab519d1a9d:rf0801122dfb80800e5541d096070a3b9a0000e9a5e64656f74e35acb9a7bff799ffa9346cff689effca42b8da547f139d2d:ZohoMail
X-ZohoMailClient: External

Use scoped resource management to replace open-coded locking operation
is recommended. CXL subsystem still remains some down_read()/up_read()
and down_write()/up_write() which can be replaced by guard() simply.

This patchset includes simply using guard() instead of some
down_read()/up_read() and down_write()/up_write() cases. Besides, it
also includes some function code cleanup after using guard().

base-commit: d5d2106e2118c4e09fef131d9889f79559b95bfc cxl/next

v3:
- Drop the renaming of __construct_region() to construct_auto_region(). (Dan)
- Rebase to the top of cxl/next. (Dave)
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

 drivers/cxl/core/hdm.c    |  69 ++++++++++---------------
 drivers/cxl/core/mbox.c   |  10 ++--
 drivers/cxl/core/memdev.c |  17 +++---
 drivers/cxl/core/port.c   |   8 +--
 drivers/cxl/core/region.c | 105 +++++++++++++++++++-------------------
 5 files changed, 91 insertions(+), 118 deletions(-)

-- 
2.34.1

