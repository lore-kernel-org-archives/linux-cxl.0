Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.90.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008458;
	b=g+HkHqXQoLd/IwO1xSxO2J59IA9wJIMWjn0ZzZ28dVZXfEkeUGhKga0dL0qFa+EnN5jk
	 ivq1tjLZlchqN7OFrVJt+cfF47DOi1L7/HTy1ZLSJkXj9RbaxiAWFdkHtOcKs78xT85Z9
	 8DBGfIcMEV2rOa6GCv+xf4PJqfFrFvbNXs51PqkAbavB0U+DBPfeh9xovCAxqYDpu3YQ9
	 GYzDftTx8nRFtBkTCp0NTYIvjk5CNoNwlbfdJFKACy6DLjkiGryjGFfWVDWAXtrA2tKlb
	 yZPq1ZWT1FJTUNeWe5ijcZd0OX0Ijfq9kuBjxNmAqTA7l4hsKFXF2tSu8gwg88suJVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008458;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=r5EGX5+LQaQtlMCbBWF8zZymFVj0pm4lFgNDqVpYpvk=;
	b=OCdvZpcQTzr5eNi4iURgYqdfKtP47x4sEfirow7IUXHuVVTJHjD5FnUfYeL49m3ugjHH
	 rIDPYf/y2BpsnrdxN9f7BCRryGv+Xmc/YNW5vCtK+gkIeobdjuVPWh17DD9HPECAU3G4q
	 PwZluywOzEkVFexWVYhfinLSbqWJZVfGHkA0bN4wa7zMTZSeTI7Sfs/V0/esGpxVQ0NUf
	 9GSBVhMjCo9g1EEOBbmPt6OR730K9DbUMoq/sSs5DzR5wGc8F4LiOl7cegsrnlXpHlsHK
	 OwQ0Prx7NcJKt0I12t5jdBOv4gHy3O0eQvOrW9fW8StezUeHhcT+QZKKeGkwgqJra7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=L6T75D6g;
	arc=none smtp.remote-ip=207.54.90.48
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD55606A31A
	for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 09:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAD55606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=L6T75D6g
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1793008464; x=1824544464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U6hnYornSWU43U02GU6HnS0UKYROmnqdzpVcvZQfMTM=;
  b=L6T75D6g1OLiqxjaHilS1jsNP9gcTlbwa+c3WJAI5Qqwf8S9VUjlb34G
   5ydp9B4dR7A4bR9lotwpYy+8zeSD57ry7zn+ZI6ZY5+xxNq8Cd9y1sYRf
   dTeSMG/ccb259YCHltjhTGa6Fnob7XJ5BzUkG1vJLkBmWBz8K2MEaM6Tz
   wFYYK/ky+Nzcbw96eW0hqOJR5IqPQLZ981obiZyfcHNFOqaGPXktMnA3L
   lQNcVN+/BxhRf1fwjTehcAOM4n2YdakLPfDTuxxxug/2d6JiYOHcUlaDb
   d9ILjTrm/ZrbuVMmbSK4+6bHf0aicPwOT3A6f9e0N3NCgrCaH88T2glJD
   A==;
X-CSE-ConnectionGUID: kMnimVEzTlqfFB+MJPUNZg==
X-CSE-MsgGUID: TLZkpcrvR/WTJnAJEHFjQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="259472549"
X-IronPort-AV: E=Sophos;i="6.27,179,1786978800"; 
   d="scan'208";a="259472549"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 18:54:14 +0900
Received: from az2nlsmgm3.fujitsu.com (unknown [10.150.26.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 416601C000CE
	for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 09:54:07 +0000 (UTC)
Received: from m3003.s.css.fujitsu.com (unknown [10.128.233.114])
	by az2nlsmgm3.fujitsu.com (Postfix) with ESMTP id ACD321800D72
	for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 09:54:06 +0000 (UTC)
Received: from tanjiro.soft.fujitsu.com (unknown [10.118.236.61])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 75DB92069EA7;
	Mon, 26 Oct 2026 18:54:05 +0900 (JST)
From: Yukiya Takaki <fj2110jc@fujitsu.com>
To: qemu-devel@nongnu.org
Cc: Yukiya Takaki <fj2110jc@fujitsu.com>,
	Anisa Su <anisa.su@samsung.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Junjie Cao <junjie.cao@intel.com>,
	linux-cxl@vger.kernel.org,
	"Wolski, Tomasz" <tomasz.wolski@fujitsu.com>,
	lizhijian@fujitsu.com,
	y-goto@fujitsu.com,
	yukiya.takaki@gmail.com
Subject: [PATCH RFC 1/7] QEMU/hw/cxl: add program-hdm-decoder option for CXL Type 3 devices
Date: Mon, 26 Oct 2026 19:03:22 +0900
Message-ID: <9c6f4c19cd72085432734ed6c427201f853d2bab.1793003983.git.fj2110jc@fujitsu.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1793003983.git.fj2110jc@fujitsu.com>
References: <cover.1793003983.git.fj2110jc@fujitsu.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a `program-hdm-decoder` property for CXL Type 3 devices.

When this property is enabled, QEMU will program the HDM decoder so that
the guest can automatically create CXL regions for Type 3 memory at boot.

The property is a boolean and is exposed as `program-hdm-decoder` on the
`cxl-type3` device. It defaults to `false`, so existing configurations are
not affected unless the user explicitly enables it.

Co-developed-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Yukiya Takaki <fj2110jc@fujitsu.com>
---
 hw/mem/cxl_type3.c          | 2 ++
 include/hw/cxl/cxl_device.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index a04dc74ecc..b65ddd264d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1360,6 +1360,8 @@ static const Property ct3_props[] = {
     DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
                      HostMemoryBackend *),
     DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
+    DEFINE_PROP_BOOL("program-hdm-decoder", CXLType3Dev,
+                     program_hdm_decoder, false),
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
     DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
     DEFINE_PROP_LINK("volatile-dc-memdev", CXLType3Dev, dc.host_dc,
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ba551fa5f9..a2c830d181 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -777,6 +777,8 @@ struct CXLType3Dev {
     /* BI flows */
     bool hdmdb;
 
+    bool program_hdm_decoder;
+
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
         AddressSpace host_dc_as;
-- 
2.52.0

