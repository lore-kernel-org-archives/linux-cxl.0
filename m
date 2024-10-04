Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994B91AE015
	for <linux-cxl@vger.kernel.org>; Fri,  4 Oct 2024 21:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728077113; cv=none; b=RcU/sj7lFld/sTa4+QEvQA9kycZFH+Bq6C8eiCl6yvC7by1c8ZBN6EfcQ7sW8JmQaJTeGA7fhUBestHzgmiHpFoFJB/DN6JiR/XC+r+8h99Jplwz07u54ilg1UTuYEdhG0jL7f4nCd4hD7x8JolIui0dsenP7k53a1CRWrC5myo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728077113; c=relaxed/simple;
	bh=xWcayRwGq99qmIJOCaLa8kUZscX03I82nm2+VL9TA4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=goeGWRKCOvV3mObUWdG02AJtibX79baUdBMVSp4tBZS8sYveUTDAzcEcWyriK6FVTflEhhb5wWTZxWKj83smAksWteUJPXEQW8G1Df3xzLg8/58O9roVCH/tR6Q1H08W1NvekpCVj9xVU+hRsjQEphh5e4Tf8DKQL02YDAlbZuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=IDfNB8Cn; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="IDfNB8Cn"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4582c62ee33so24172251cf.3
        for <linux-cxl@vger.kernel.org>; Fri, 04 Oct 2024 14:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1728077110; x=1728681910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c38DjANBRpYnTCiRKoh3ao5Dt3VewIRXoROl0i/M6LY=;
        b=IDfNB8CnXupAkFroRP2q1wzwSTjZnGwOxs5OJ2CMFPei+0LK60UK5xQl5DeJ28qB53
         G8tWDUfs/wiWxaqMFTO3P+aYuCp9a70uH/jZf8mhhvWekBwVKMXmB5yREEtPhbSE/en6
         1dmPLkEYqLtGcYy5CLzENqWxmq9ySbtpwXXQazqw5QKEc3Wz59iO0/mqG/Fttl6V2K1p
         igW4Evr8dMaEJS1MiUzR3V7LkFLEcofOcLQhlUr7Ix9M+Wi2JrckyRSr224rjJfPk33i
         AABVzB29U31iuGIriZNnYur+J4GxBfIGRsnMTyE87EVrvH/HMb6zickseshsmJUCLOzU
         TulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728077110; x=1728681910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c38DjANBRpYnTCiRKoh3ao5Dt3VewIRXoROl0i/M6LY=;
        b=oO1l9ufYzbbTT7IoUqBowBPYvaFRuO5egIChyvx1IuqtgBGQsbxz7z9A/HsojpxGaG
         SNdM73Tg951vEZ/BqijLw+jpROWlwADGR6Xb+zBC3R102t//eIeXcCnJAnZZhzjsAp9B
         Rg50BKSvPH5u0mBmdk0Mfawj7JjwX987ZWTymt+BgU7/iLS5tPzkFE+p05I/YypP4ola
         FrT2gAYrr1G73y1itOMsg2L1O8h7++RWH+YTqNo5dl8tw0uTihLrLiSBy0+IHI9qHuKq
         sgZibShA4CUxCQpLWNjNCtlIz2nbmp1+QvGy+U0qVyhlq3vSjy8jPhYt+j2WJDT89D4y
         ScjA==
X-Gm-Message-State: AOJu0YxEMg6nymjAr0BG3+dAiiQw4/GlQVtzAjvZexHbSchaa03fScaq
	uA+b3IsLeMS3WZhUVNulH3nsWg2dBob16jn2EAMjLgRKhLqEd2lIn6CnT8Hi63dW9l23/0OuD1J
	R
X-Google-Smtp-Source: AGHT+IHiEiOEDSUe+eNwT3Ozk4QbVjqwugZuiizvLvWkgugVkAkEIZArS9gYMMA4Xs2+CzRDpN8KWw==
X-Received: by 2002:ac8:7fcb:0:b0:458:40e9:8d0d with SMTP id d75a77b69052e-45d9bb3a6d9mr71503881cf.58.1728077110093;
        Fri, 04 Oct 2024 14:25:10 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da74ec504sm2660471cf.23.2024.10.04.14.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 14:25:09 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com,
	Jonathan.Cameron@Huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	rrichter@amd.com,
	terry.bowman@amd.com,
	dave@stgolabs.net
Subject: [PATCH v2] cxl/core/port: defer endpoint probes when ACPI likely hasn't finished
Date: Fri,  4 Oct 2024 17:25:04 -0400
Message-ID: <20241004212504.1246-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cxl_acpi_probe, we add dports and uports to host bridges iteratively:
- bus_for_each_dev(adev->dev.bus, NULL, root_port, add_host_bridge_dport);
- bus_for_each_dev(adev->dev.bus, NULL, root_port, add_host_bridge_uport);

Simultaneously, as ports are probed, memdev endpoints can also be
probed. This creates a race condition, where an endpoint can perceive
its path to the root being broken in devm_cxl_enumerate_ports.

The memdev/endpoint probe will see a heirarchy that may look like:
    mem1
      parent => 0000:c1:00.0
        parent => 0000:c0:01.1
	  parent->parent => NULL

This results in find_cxl_port() returning NULL (since the port hasn't
been associated with the host bridge yet), and add_port_attach_ep
fails because the grandparent's grandparent is NULL.

When the latter condition is detected, the comments suggest:
    /*
     * The iteration reached the topology root without finding the
     * CXL-root 'cxl_port' on a previous iteration, fail for now to
     * be re-probed after platform driver attaches.
     */

This case results in an -ENXIO; however, a re-probe never occurs. Change
this return condition to -EPROBE_DEFER to explicitly cause a reprobe.

(v2: additional debug information)

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1d5007e3795a..d6bebf70d142 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1553,7 +1553,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		 */
 		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
 			dev_name(dport_dev));
-		return -ENXIO;
+		return -EPROBE_DEFER;
 	}
 
 	parent_port = find_cxl_port(dparent, &parent_dport);
-- 
2.43.0

