Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE062D97B8
	for <linux-cxl@vger.kernel.org>; Fri, 13 Mar 2026 03:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773373895; cv=none; b=Rmcm3L+o8Eqm9JnJCdOY84Rjmzyoz//es/AVzs+IFo7vt2ZbN5w/baWatqRfRfBkLuizVnZ07TzVnLk0vme1rJsv+lhGeVqSnUmD5/G2cdJ8LdZyiEQxaeM1CzuBcJ+sYj5sYIkFkCnLaexiZRuXfiIoVcQ3dHr79CCXQF5vbRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773373895; c=relaxed/simple;
	bh=cnnptNUhMltrKlyMjaLxe5WMhNgNFEdG8YnarRRsgts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZlp6MCLt+5LF0SkDiNZ8ZoKWLOX+7puasqFZValUud74dD5uOEbKWv/EAduyP7C1y8RNEe17oCj0vxvVT7HuoJDwGUdvBQRzaHRhYS2gHSbbs8BEE/xwrIgX+r8fWTE8LLarS4kaMR/BbItSKG2KlsL17vCvGZK23An6kdx22A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBP/sI0K; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBP/sI0K"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-829a27414a3so1016977b3a.3
        for <linux-cxl@vger.kernel.org>; Thu, 12 Mar 2026 20:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773373894; x=1773978694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cnnptNUhMltrKlyMjaLxe5WMhNgNFEdG8YnarRRsgts=;
        b=cBP/sI0KZSl15S1cjvqhuFhVJbeFg8FZqrpglKeaYakzLLbIQ1ofNDC5CSN+/E4b/H
         7+bkrui5h+M3cN+d2APfqERx+orMhCS63uwq1o64vq7H2CJowulwoWB1SAqeC/rTRRrJ
         DrGxMzsoHo1Zv/8XUucv0C3pX0QOZJh+KzU1/GdgfhoZWWStjcOirLpNlZ0y4zUppPAO
         Lk/BgrP4rHZcBJng9krmseMG+9BU0fXerBE991xFE+OD2n/yHwfQJrzCgxa35ThklHdQ
         mxCIueIJ+oQo7SHXz1DGDpZdg1pjJK7+bD5X9bTPXXW6YH5ywFpM2N8xPfycRU6JghgA
         nOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773373894; x=1773978694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnnptNUhMltrKlyMjaLxe5WMhNgNFEdG8YnarRRsgts=;
        b=O5roPwIVqCla4E84ufzsM5NOpDYlmtdmrThFRetra2O+ATOTxeKZNgCwkv1pzsP6TT
         oYSUV4ikZ1kmIi1OoTUeJuN3OIYEzoySraICcUj+B8cly40/SDI+zeC+nvjEBnHfP0VI
         yHfAFwKmmPRbFF+vH9cRN10+mlmMv1RPD9zZfBr1j9l17plozSTvDHp9d2+ven/JBfml
         gcR2DocLZbn/B6cOcnW1VEQ7cAZh5GYoba7G182z3O0TjG/Offe7237sJdJc3+x+TliU
         6D0hNSkazmhHAQbrNSBBWAqdEFP776q6dnLuy9OeN938Z2AX/9TSz62ZOv7aytmzPX60
         g+sw==
X-Forwarded-Encrypted: i=1; AJvYcCV2Gsgzj4RIJiuC0eO88zMzry6z47rhpZ5iWvAYccKPH4mWu9MfUkE8zXwCAuHetSrRTI23cstTjuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoOEBEAQkQnoAOnHOI50m4DuAzWvTwNfGNILt5t5nBzQZlb8HI
	ObggvJo+lNHl23Nbc6Xskoq6o3f6cW1YghufIhkgeRkYafyoz6jw2RmY
X-Gm-Gg: ATEYQzwRLSHkiKOfEXaIFIj7zFzRcic89nPH8JoaRwMvq8TxQnVb9zkfl+/EJR9Dmtz
	YseCNhxO3iSqTPXBNEd/2h6UpF8U1qMSYwyGeodzhBt2mdmPqGTBIAnisiNa4YROj4xPYUOVxq3
	nVclP4xDS1xuF6D0QwO9zjQ50BqyTwRSWO52ur1UhVHMoY5dr3RwrJnx6hCFR0yazj3lAEZyEzd
	o1m3zfFWpFHaO2OD7NuTzWOp1Esuve1O7filk7hfUTwRBvzD20Pv8SZ9yCXJ6IzbofCBUG9xoMe
	n5lvXLJB3VJVknH6Nw+dWiYl2vJdUmgURlSdBTZyrAxb9y5zlsI+0y8ST0UhmO4KLtiLZgSTuYU
	zdFEuoDBpzE3iMT23tVrJm3ZeMqDeydRir4NCGEWpXXItnaMMcvY2ytuhIAp3/zHml/16RkfyDq
	XCrgDdjY00xOsPNrJnnLYuc3HpBqhxIDFMbtHrE6nWwopwFaj3UAuU69oBQein3gg8aN8G2ikJX
	3o=
X-Received: by 2002:a05:6a00:7617:b0:81f:4ce8:d64b with SMTP id d2e1a72fcca58-82a198ad696mr1148602b3a.44.1773373894195;
        Thu, 12 Mar 2026 20:51:34 -0700 (PDT)
Received: from [192.168.123.240] (n058152022092.netvigator.com. [58.152.22.92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07343719sm4525615b3a.38.2026.03.12.20.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 20:51:33 -0700 (PDT)
Message-ID: <aed07229-9432-474b-8498-5e23893e72fc@gmail.com>
Date: Fri, 13 Mar 2026 11:51:27 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mempolicy: add sysfs interface to override NUMA node
 bandwidth
To: Gregory Price <gourry@gourry.net>
Cc: akpm@linux-foundation.org, david@kernel.org, dan.j.williams@intel.com,
 ying.huang@linux.alibaba.com, linux-mm@kvack.org, joshua.hahnjy@gmail.com,
 linux-kernel@vger.kernel.org, Jonathan.Cameron@huawei.com,
 linux-cxl@vger.kernel.org, dave.jiang@intel.com
References: <20260312091207.2016518-1-seven.yi.lee@gmail.com>
 <abLl84pc7tavuieW@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Yee Li <seven.yi.lee@gmail.com>
In-Reply-To: <abLl84pc7tavuieW@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Gregory,

> If userland is setting the raw bandwidth stat, why can't they do a tiny
> bit of math to figure out the preferred weighting and just write the
> weights?

We're not setting the raw bandwidth stat directly, but overriding
the top-level bandwidth to observe the final effect.

> Should be posted as [RFC] then, I don't think we want this upstream.

Thanks for the suggestion.
