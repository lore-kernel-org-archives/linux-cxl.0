Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC881BDA8D
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679906; cv=none; b=NJRVWWmj6nO1fx4LU/YkfK9hy9pagTec4N5h/4RjSmnQeBfYb1KS6n2lNvj44+fiAn6ClvwgRavtYssuVYKSGg/GaN0gZ3vgzKS+TRnBVAsSfLmKutNUrj2UJuozipGZFzguWAjeUNuwBg+BGSPlO6iYGS1yPbqSvvzWsRA/rsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679906; c=relaxed/simple;
	bh=Wk4m36HxVoJP7Mpb41N5RK+yLcPsKN+HtRcRCGZI6tc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nwb1A4iY3LTXX72IznLvXk9rLFEMNv2iWODTBCZbKlu8GJjQmhqyBg8Wsh19JJRa3YkJRVTVflwlBzuB8wcbNAqSUliHlLTTq4MU0fNLHrOhLaKoYlppkWpMCs2NLPAzs+N+IiV8L2n53598/hgdhqiuJyGTC2HRblbe8wn6EFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fqOw+LRM; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fqOw+LRM"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-382171fe8b1so1172971f8f.1
        for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 06:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731679903; x=1732284703; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E36S5suZaA+k29KC3eX4X0rDi3GcvG31UdMJKLwEsac=;
        b=fqOw+LRMlca6QmF1YfzwyftD29aDZlSOIsjq1Cg/sXLy/eErLY3RCSpvnRW9v41kbh
         o5vYgxjjFAklO6WHMVr5iVhN0ILSZPR3rSmFOlF+4rlH8BgQ7ddf7dnA2c4GRxTH5l4T
         ToGRqTZIuXR3F6Bi2C/6iaIR+3YSzjr7huuGBlyY8L9/1N9pOEvtg83fa3LYN7To9684
         cUzCpn99lB+iLeKJlrcx/Z42V5LrI8y0wzyiYbnCV+TUIp8kRzXDO2cLaWYUltrFL/hJ
         xYVIbqBOc0B+wL3Y9Fq4k9vnYLLCqu5j75GBpFwpJdE7fnuzlRRtYf95PdoyjKJaJ4yM
         vo0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731679903; x=1732284703;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E36S5suZaA+k29KC3eX4X0rDi3GcvG31UdMJKLwEsac=;
        b=eKQS8w+gdNbKF55FkBjcj/2n2/xk4znUiSw1KuJDbBdPKIjWt5Pu0TBRCKl2stWGXg
         qjA8RSDjgbnqJIsbEe6i8RX5c4Q+eD8f80duAyBy3SYEGb31fLYxXkln/rudHn1PKiV8
         wT9xZs8JQ05lhsMbsYm0iVDCrAnKNz9EJzL3JsE1Qcz28HsGmnIl8x6jHBzJJ5hPlfYX
         AKsn/DMgMkix3OXKbM2XWCQ0joZPYJRFM+oN9ZmpkfGtstGpA9wZlIRNV01aWV9r9ApH
         YVo9WXCNk/6kOlBr65NDUnDbAyQd0gtFeb8ljD9c+Oo55WiskMWxbfINBZ0b9iyd0o1J
         GNWg==
X-Forwarded-Encrypted: i=1; AJvYcCWJU5oMZv9YJ32hPXtxOjUr+TtPM+Rhj7c4OtW8PR6FJHkkB4JIMDPvO3vMhp/guk1NHYYEZxtvjNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7YVk1obsm1+lyHGKdXJbTtW92DJ6ZV5t+9XGBuJWO5AxYZPp4
	+XPaN9IqX2xLcAUMlE2KJ9tJ8tbnca5CdZuQA98im9EvekwGjfAB0zIAPWzAOBQ=
X-Google-Smtp-Source: AGHT+IElhNepFKgyZvA43CAogGOBs5mDCZ7d9aKxT445VRDS5ik1KPFiZoHdyzkpwafl4WO7tRMMQQ==
X-Received: by 2002:a05:6000:38d:b0:382:6f2:b8ec with SMTP id ffacd0b85a97d-38224e7052amr2705682f8f.7.1731679902709;
        Fri, 15 Nov 2024 06:11:42 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada31b0sm4585711f8f.1.2024.11.15.06.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 06:11:42 -0800 (PST)
Date: Fri, 15 Nov 2024 17:11:38 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Ben Widawsky <bwidawsk@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Sasha Levin <sashal@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Yanfei Xu <yanfei.xu@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-cxl@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH stable 6.1.y] cxl/pci: fix error code in
 __cxl_hdm_decode_init()
Message-ID: <380871e1-e048-459a-adc5-cfbb6e5d5b94@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

When commit 0cab68720598 ("cxl/pci: Fix disabling memory if DVSEC CXL
Range does not match a CFMWS window") was backported, this chunk moved
from the cxl_hdm_decode_init() function which returns negative error
codes to the __cxl_hdm_decode_init() function which returns false on
error.  So the error code needs to be modified from -ENXIO to false.

This issue only exits in the 6.1.y kernels.  In later kernels negative
error codes are correct and the driver didn't exist in earlier kernels.

Fixes: 031217128990 ("cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS window")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/cxl/core/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 8d92a24fd73d..97adf9a7ea89 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -377,7 +377,7 @@ static bool __cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
 
 	if (!allowed && info->mem_enabled) {
 		dev_err(dev, "Range register decodes outside platform defined CXL ranges.\n");
-		return -ENXIO;
+		return false;
 	}
 
 	/*
-- 
2.45.2

