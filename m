Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EC413C914
	for <linux-cxl@vger.kernel.org>; Fri, 21 Mar 2025 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742565590; cv=none; b=RHLyhHsDhh3PXw/tbAHd6zO2frltFt7ofb9dyGn8vplmsc+V0b9g9ROqd8bT21xtgrrVTl9jiH9NdkKd8DNYNzsIMKyINV0WfCxH2RpPjbD8BLQGdET3MUvl6SqbLxzLGOlmqLLZeykVN5UxO6hIkPudb2g2HLqQs+vdSXWZZU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742565590; c=relaxed/simple;
	bh=HqRt79DUsL4J+Cje/U08ihks64TvmbBB60ER7m4KqIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fnz+I2hzARGexcWb8tFQJ51ST1YO0uKqL2dKS3skereuc2vz7gLvMaMNOVIXfTcw20lEdbUu9FUovJpvvigRCN5iyRHs6drTNxt/Tzc6tBMedjLJUE/8ldaX1QiiqP8i6/Cne8eWfP6UvWrQCAktN9lzbrVOlOMJAue9w437QsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=hCWJY4H/; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="hCWJY4H/"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-476a57a9379so27878851cf.1
        for <linux-cxl@vger.kernel.org>; Fri, 21 Mar 2025 06:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1742565587; x=1743170387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+9dAeMLXO1UL2jebDZiJp6MgSYhpvl7GGhlGkzkHYBE=;
        b=hCWJY4H/HvCvnT1jLdtUK2ei//S4FKzJ86TrxA+ffD7axcaxJ8tsd+5Qm83KmnsBSW
         Usm77Egw5Ca975GFTLgsm96hanNsvwwcf4C4bwXBQO4Sr+vRUpDD9H2kvQ9xN6gc3oxI
         zQ3LmuBXFBAej+pvIU4/d9Q7sTpYw+NJCldr/JI5iTxK20T+a26I+LIIQ8QYB5vmJ3z/
         Gv7iUWS58K0ZjwsLZ8DXmxrd0le4j2Fkajuxt/opVMzX1QyZW3CBBevVAVL6xyePNTTK
         yFULwQSy/CtFmc/rA92vKZ0NLorkJSvMDYr5dt5VvG0tMeZxtzZQ8R/Ia1k2g9MtAn+G
         yk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742565587; x=1743170387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9dAeMLXO1UL2jebDZiJp6MgSYhpvl7GGhlGkzkHYBE=;
        b=dXnCLE/uYnqtDBrsgrrU8zm8p4ku3fyU16M0nU/BnnMFr0IiXsuM44TtKJ3dsajOng
         DjJMir/0Ro6qWex1QNn5Xsh8x2OYok/RSj0xBnomM0O1P0gkfeqomGdMNjpHpWIbKn4B
         8klQZg3+Gc7Cv42I/lWqkZcbbpxSpQFLCUM3zPrF9rjnxUbkyQUe09jkU1V4eMZIxhhV
         WjE1B/NIfegeVmMfzeYk8qXp9g5tmQD5lvWAxazMTcBVJGOVTrGPwBsRn1EnzKsPwb31
         FAj6PAKCAJ/f8ZFaFXWZSwCSwvMQC6X4cwOZPNqEx2LhxVT9DNR5+0PHUbl4+cvWS2/b
         DNtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGGo2ftxLiWEZHi0GV8iBKBtL32ggoZ5Dt0h7Vkrol+zBgTO1Ou/0jyPRUMq4bW0luGo3NRbdqKg0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz3dc4COn5fVEd5NgVinLBmlNViSrOtAX1iW4CmPP0Jut6iut6
	L+vojH3O74TnApiGXCEtA8wWgfcpTVmfgAFFVGqDVGvpSkRGQsQEMYmOKnvlfvQ=
X-Gm-Gg: ASbGnctyGoQuXL3332pfmQoya80DZAMeztVWRSSP1bDShXDPF48VAsU2YcYHsOF9bxw
	0pcr+fDzOnj2ADSmh9U4P7UdUmaob96ThBT/9pEMx3OqKmvLPGEXO05xRAXL5XWgGSVY5UAtu9I
	KkKjWEFIt3XQXJbjx/2LfNeAV/Lblh11i5kJhqD2raXVR+3rAvmuolKQUT/TQKRTLeHns/9duXy
	iWXZPxh/BnZNWOrJQ+w3xH8sDgFsUEA1PbZ3mLfSmklJL9fpKXvRZuJU9vH/8f/emZi9HOSfS6h
	QnTG+4wixDrdXKdP+l5p46GChydNPZHADHC8NpHAEng49WxMtv9ZFOdx5TiLp9+kME5cVYZGPbE
	PVu80fLCty6qg2YL7ZRW+TbH6f0M=
X-Google-Smtp-Source: AGHT+IE40rw76FodwmzMUd5ZJ5Utk+psc3XwsJk0EM0cBH/ak9gdBIcEuV42/YBp1/X9s3GgwHKeSQ==
X-Received: by 2002:a05:622a:1148:b0:476:b783:aae8 with SMTP id d75a77b69052e-4771ddc9124mr46926961cf.26.1742565587375;
        Fri, 21 Mar 2025 06:59:47 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d18f7d4sm12292181cf.37.2025.03.21.06.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 06:59:46 -0700 (PDT)
Date: Fri, 21 Mar 2025 09:59:44 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	joshua.hahnjy@gmail.com, dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com, david@redhat.com,
	Jonathan.Cameron@huawei.com, kernel_team@skhynix.com,
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH v3 1/3] mm/mempolicy: Fix memory leaks in weighted
 interleave sysfs
Message-ID: <Z91w0FQ_CeWCHZRF@gourry-fedora-PF4VCD3F>
References: <20250320041749.881-1-rakie.kim@sk.com>
 <20250320041749.881-2-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320041749.881-2-rakie.kim@sk.com>

On Thu, Mar 20, 2025 at 01:17:46PM +0900, Rakie Kim wrote:
> Memory leaks occurred when removing sysfs attributes for weighted
> interleave. Improper kobject deallocation led to unreleased memory
> when initialization failed or when nodes were removed.
> 
> This patch resolves the issue by replacing unnecessary `kfree()`
> calls with `kobject_put()`, ensuring proper cleanup and preventing
> memory leaks.
> 
> By correctly using `kobject_put()`, the release function now
> properly deallocates memory without causing resource leaks,
> thereby improving system stability.
> 
> Fixes: dce41f5ae253 ("mm/mempolicy: implement the sysfs-based weighted_interleave interface")
> Signed-off-by: Rakie Kim <rakie.kim@sk.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

