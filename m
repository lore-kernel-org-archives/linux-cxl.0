Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F58537FF
	for <linux-cxl@vger.kernel.org>; Wed,  2 Apr 2025 19:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743622489; cv=none; b=cQxxjck/yCePFdtSiTBhnm9usei8hRSV4TlDTKERKwXhDf6Yt17CnZT7HqOI3Ynq7wYdqnM65WVw0+nbJpBHWOoG98wo0OyRVIg/qWY8jdXjNkE8WZyXZKlErk/vt54bULbprrW7fxFoIWafc+HcNyYxvrE0IUSr0VCfC+hpBvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743622489; c=relaxed/simple;
	bh=ek9FwTvpWstS6pLwqPkH9Wk/Ja/hmu8/yMqt2I2shm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DodVkely5FUaL64qDpIzeZ8626Ge2ig8RmaoLDY4NyAlRWqNQ8dRuvifi8ChNe27TmChb57nHmCsOszC3q7kIFk/GpXxQgvR2i7N/eWEobUD97wX9kEHYseGU9I1Mit7ZG7wRq0/g8iqCJefz3na2CktFPCksTDzG4+M1uUuu34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lpCkFA4U; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lpCkFA4U"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c55500d08cso10158485a.0
        for <linux-cxl@vger.kernel.org>; Wed, 02 Apr 2025 12:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1743622486; x=1744227286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ImvdCtilJthaEiYhafhJyo2XapqFCnVc2mKBR7Opxws=;
        b=lpCkFA4Usj+c9ww14y0XCttA78VZ6Bz3jpxRQDKFFYoKcy/MgzmJ5VF2aHppR6kx3V
         tjR7aEQHvwMqD21XMficXcpi3JUeQNZf/MynnRZkw2OG5HiWmGoADnwOrwYFqI/vxT0x
         lKy1InQeKPqkJrUgv+HPu/weVjveTQcsIWcQXRY2/jDYnYLJ4b60J95ildwSJt68Ua1x
         SQmVBL9hkDBOCVAdTUBiiWnmVSjtDTMEgkE4GEDgyeB+6+jCe/j5mNw7giZ08qrgD9HH
         Gd1KwofNoZnV1DBn0HUkcAagPF3Y//zOoTObiav9s9GniYa05DQdm6ynbIfeycsl53G4
         NnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743622486; x=1744227286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ImvdCtilJthaEiYhafhJyo2XapqFCnVc2mKBR7Opxws=;
        b=v8+Qvo57XRX3OoCmYwiCK+Q+KPpF8QYii2j2OiG3Gh0a1q5Z4T25IjpLEc2Pvk1k4b
         XkOvbpL5+ewbzxL6bbol9qRRLcoi8nPNMOW/wUinWho/Hqxu4a2mM8XAJPuzSq2JZae9
         ZmyvRH8TTsvtSA8IBz9j9Q/DgFJyYj/aAn7wS2mpabNNFikfSCz3F1Qr4idz4+NsKnEE
         WUiRhzEHR5nJ3Z9+qFRIw/nW3xxQgUZQ2T07R79Qknpese4DLv5CV/GEGjs/Lp7sAvsL
         LhSvLdYJP3nDVUqYzLsbvbvQHMJJFNYVlnVhQhg2EVyWHFIdrxZ+m8SwVOnjdRK6yySF
         TUGg==
X-Gm-Message-State: AOJu0YySSf7PH9DwXB8A8uU/tlAoh+ZDQeFXJ6meiQEy+tcfw7XoMXHQ
	vGwGONJdv+duWfKU9FMu9NGiIqMsuPmhUVItbEj/FejX6Oqsv1gE1JrxJ+qy6rKHLG5Thxbcw0Q
	3
X-Gm-Gg: ASbGnct6f3caiUMZo8Md0XMIayTmW9T0/5GbFVOUoUcpMZsxsbJPwGmeZxEk2qGSmMc
	+oTHooxeJqDHJ9DI6JYYGFgiKFTmDt7Iuy+QsDKToSerMR9QbklGoVD6Xpk2fkoDCk/PQNC/qPB
	GoxqBgHB5LPKrCLWRDZBuFypZt0apbI/emHF1Mt5mHUhelish+UW46NNQACjxyOvgLxgPziAxEG
	wZJC75kjGxGZnsPgleyqQn32DOMcWmFqND/bqmCrNRccadLNC2bLoDmclHT8aR0pK4hpePdL2U7
	sqmC5Fq0a/+66iYZQkat3OJWJMPR6F7QxKfnwgFi5HhCVb7dWCUP086lN60qZdDM4a/poqK9Uv0
	SDNZ5rRGM9kR7zHn6yFFa1EI5259SdqSg
X-Google-Smtp-Source: AGHT+IE9PJpwixkYXExJXaHEoP0KU4gHdYtznJh8E1BgbNuRx6ru/Xr7FW8dYCLFwds7hsZNLKVxhA==
X-Received: by 2002:a05:620a:461e:b0:7c5:a513:1ff0 with SMTP id af79cd13be357-7c76645c32amr642482385a.34.1743622485812;
        Wed, 02 Apr 2025 12:34:45 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f777dea3sm826277685a.102.2025.04.02.12.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 12:34:45 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com
Subject: [PATCH] cxl: core/region - ignore interleave granularity when ways=1
Date: Wed,  2 Apr 2025 15:34:43 -0400
Message-ID: <20250402193443.944654-1-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When validating decoder IW/IG when setting up regions, the granularity
is irrelevant when iw=1 - all accesses will always route to the only
target anyway - so all ig values are "correct". Loosen the requirement
that `ig = (parent_iw * parent_ig)` when iw=1.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 04bc6cad092c..dec262eadf9a 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1553,7 +1553,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
 
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
 		if (cxld->interleave_ways != iw ||
-		    cxld->interleave_granularity != ig ||
+		    (iw > 1 && cxld->interleave_granularity != ig) ||
 		    cxled->spa_range.start != p->res->start ||
 		    cxled->spa_range.end != p->res->end ||
 		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
-- 
2.47.1

