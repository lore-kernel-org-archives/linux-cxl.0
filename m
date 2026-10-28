Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793170211;
	b=x7X3K9TjuYV/dWwfM0EWfZGsUE2ZlEMcqzihOhpF7xQoCv0+YlhYoR2SWcz2TjIqIPss
	 sd+fd3manpc7iCip9PhlhotimFOy5X5pewRaM+h52ve9RbAukEnt1zLfhTgojmR1NutTu
	 t1ClyTFwXNjtOfLwtvctKyySh0Fh2vmpBpLZhIPnOGADvZIlxHbFqiaFchMr68zal1+6R
	 ioDkNqD3e4a05cA17u5geseINsoocDydrhLLN5KXqcQbg5D0IV4n+SE6hHw55hiPyjF4I
	 RYMRU9SaEuSG9+GoRqAuygcWdY4IxAaovNkhSLiLVyL5JwfYHIQdEdmNy4xgRBMnOXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793170211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sFhRdI8EQ8MK0p+CW7dH/qNlkXIP7SsPBqhbqXWLgo8=;
	b=ivnrMZAB0ckTHeh1Ht0amRLZ+DXJL748qTXdPw2Fv7KOGbCpW4QpNGBUuL2A3/t13ymG
	 GL1ssyfSqmYauVJdqhgRsrNgfHZnazGjmrC0H9X97pRHo+icE1UX4QEuCttZeb2XpaoTW
	 0r78ZPbCcUJeVj7bG4OBCmzpy4JabMgdDN648y9Y1XRyqxM6zMqIFjzITVESY19NRKSME
	 9UJeq+ZI5qRbEeX19tK2NUnS/kOdBGKFO7o8US2wLhAhfF/m4Jk1OcmYnBwEwYnFgd98W
	 lYBkIqTDObpOz7SLCo9tcZ++KnnePDEXJ91AXzIf88473pJfMrKNsTrgkX0dFXtZP7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HqMUEPXJ;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A805F606A31E
	for <linux-cxl@vger.kernel.org>; Wed, 28 Oct 2026 06:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A805F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HqMUEPXJ
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a208d93758so5739725e9.3
        for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 23:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793170209; x=1793775009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sFhRdI8EQ8MK0p+CW7dH/qNlkXIP7SsPBqhbqXWLgo8=;
        b=HqMUEPXJVdP6J1IEnR1xcnYhEHqrxYYo9t0WW9OF/y887mPyMsPavGLyLE4fOEPvAZ
         1rpgz8llkCN4XHtVNIULxpHhY0O6FtZfYMtlD9mzH1ffpCb3hcEuBxQ3O+X6UX3dedGl
         eUKS88Psa82wHjupcx01IGEd/7aq7NESmRkc+AFd99PpHe3YQunLvnQ8PzPCFLwRncKK
         46/eaYSHd/oEorjebO2mSIASZUKIhXn8hhui0MAXOrUftee5I45COXgHYu8kxZWbVwmH
         t7cC7qER7Nq3cqj/uFDOnK0kR6KTXPuGuMdwTRkz6gO9cQT/rhknwACglRa7thSXu15P
         Uimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793170209; x=1793775009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sFhRdI8EQ8MK0p+CW7dH/qNlkXIP7SsPBqhbqXWLgo8=;
        b=FuujqfcHE1ncvgWyjRHU1AVJyFFp1VZgFsHVWHuZ72UfSyQUxxW2KiaNOc++qSmbHs
         D90eG+2oWR2EoKIOKtanrgcpOueOnLD6+GQxC+roNYwSggufgdvVgVGcMz87DbpeK+v6
         QcFLi3GKhuHy1UOudmtT2+LhHlTsv0VFC0zDoMyfTKcVwV0k4d6CHesiZDdGibDikRCi
         4K4TXDLbO1EQaTj1beter21A4K1nGN55f8BSP4wa2lXjuct6xNURIhVw1xgW8I4vjC/e
         pc2nRsAdtpYUeedPn/Ii/vOF5NCcAV9veSkmdhZvILopqziIyY1sYaE43DcF+5i7v9fD
         MdyQ==
X-Forwarded-Encrypted: i=1; AKwUvBzSmhrhxFN4cgaR3/QEcilFxhrjCIqRhTQJMJxwJV1Zf9zHFVf3OQy5uQs7P3jMbP9zNJ6lXpI2NV0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJo3tuMGZaYo9qyX3BDt4QjZLx7IbVw2mTGsuT9PUPrYSteiEAm
	2rVWBHx1CB0sNm+rufWIN5ljTqZrkXIC4mabEymgPFxCrzEK/1osMy+v
X-Gm-Gg: AYBFou2Jfqq5r8joyKXu/8FOj9Hwei3BfXqYFoXloHDB5XLfJGdpWR52Y69Uv3H7azP
	8kgHcjY2Ps3mKzt7l4kdNd4oEAhLWxqj1PDnEkW+A9byJvvxbWXqNNR7EgCRkse5kTRPra/YsGT
	SWrMSIDglLCRMvgMlicOwnGhYRoz5YiLYOhkM6lQE4Z/wFSaJuu03oO7xafxkDOyIXEubYHs2jj
	7hh0vYWJTQVA+K7LE7WeRWnmuqA0BlhzEOT7yAlOokAglSOgytMGkJSOpVl70GxIj1cxFqk7kFd
	DZuZhqiaIZBl/1Zk8SyPYajB9qvW5MnTQXyFUxCBPluhQ+yVXDyJ9CEtPgJMMVv8UGd6voArqAd
	kJDsAavLc+RhtPhw8Teevemlz7cUA636Fz1tuTNzEf+nR6iNBy6f9App2nbqihJokAM9UoAAzG3
	pQ5yHrvSQ/EMHjphS8dxS3hgncrfcF8AzTBkf/k5MZSzEPYeP+OEaTTaybvfduWOewz74mARiAO
	NfQh53Cn4ADqO7RXCrsSRq9SHacAOAzAi6bTqRZkK7ymvuRqto8965shLRO112/JpwuFDfFG1ww
	gnNx4Z3g5vIr3VlRd1Mhzg7B9zAT89lSZpY=
X-Received: by 2002:a05:600c:154a:b0:4a2:fe3:121b with SMTP id 5b1f17b1804b1-4a9678c268dmr27227395e9.28.1793170208726;
        Tue, 27 Oct 2026 23:50:08 -0700 (PDT)
Received: from LAPTOP-AVI.lan ([2a06:c701:4778:c500:80cd:d127:b224:9e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a978d57b39sm38767015e9.10.2026.10.27.23.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 23:50:08 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: Dan Williams <djbw@kernel.org>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH] dax/bus: clear parent drvdata when releasing a region
Date: Wed, 28 Oct 2026 08:50:01 +0200
Message-ID: <20261028065000.580077-2-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
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

alloc_dax_region() sets parent drvdata before reserving the resource
and registering sysfs attributes. If either operation fails, the
region is freed but drvdata still points to it. A later allocation
on the same parent is rejected by the non-NULL drvdata check.

The devres unregister action also leaves drvdata pointing to the
released region. Clear drvdata on both allocation error and
unregister paths.

Fixes: d7fe1a67f658 ("dax: add region 'id', 'size', and 'align' attributes")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 drivers/dax/bus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index b809e1a264afa..dceaa395760e7 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -627,6 +627,7 @@ static void dax_region_unregister(void *region)
 	sysfs_remove_groups(&dax_region->dev->kobj,
 			dax_region_attribute_groups);
 	release_resource(&dax_region->res);
+	dev_set_drvdata(dax_region->dev, NULL);
 	dax_region_put(dax_region);
 }
 
@@ -685,6 +686,7 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 err_sysfs:
 	release_resource(&dax_region->res);
 err_res:
+	dev_set_drvdata(parent, NULL);
 	dax_region_put(dax_region);
 	return NULL;
 }

base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
-- 
2.43.0

