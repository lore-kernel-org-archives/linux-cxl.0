Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A081632C8
	for <linux-cxl@vger.kernel.org>; Wed, 28 May 2025 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748448945; cv=none; b=VxFyifKRnxzj06w7FN9TOPthpXyGarme59FhZMSMTtEj8S42M9VfO63Acu83TWOPr2pztwRpobbc4dfcb/dfbVUv1AvNhOfUkbytwM7WidHoDcS2ccEH9uFxrGiIiaeeBPpYCGCVLeFFdsnqxfVfT27CByEEulUqZlhnF1uNKGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748448945; c=relaxed/simple;
	bh=7szsciP4s4R9wknqXBXBTZqN3lbaKfXPhicwDQ8Hmdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gx+eQ+Rpr16FWfHePBZD6v/We6w9KcfWrxXrhTEu8rJMKPlcDnHWTp6eUUCL8cSCZHSfaqxebZ7CI9GC4Cgvns7ERejL4HINPqyhBQ2BsebXuJ2vsiS5vbtUlztr20U8Gu8BNlcRYdr6VAS0mI4TJ5d6jB7KchWwIvQ6F0s7s/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gL3Skzeh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gL3Skzeh"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-442ccf0e1b3so422485e9.3
        for <linux-cxl@vger.kernel.org>; Wed, 28 May 2025 09:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748448941; x=1749053741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+C1RzNTr6MbSo58wcEFxOVAmKna9VJA+FNUjpMEd4H8=;
        b=gL3SkzehCRPTbEareMaVrIuuL6aN9um90oEuhc5yudHJfX8iUpFwRjTv6VAtRpVUEu
         ecAF5HVrSVpLSDuTcwdCGvtq+A3LrsFZWosbDZi4JZQaHdkErRKv9mq2KROHE5T7r47x
         K+JFF1SZaGOziosFC3+L0UHqqfItztS6aMDZeNddyNnIyuQBrF+nR/75OSlXJZwtTEzY
         dD5nuonu3a0OvG1FFjc1Hp654WRktMqyWlWOILhcM+AJBXOP9HoQuitiDqLX0LdIMtYV
         AXH3N04AZ5E+nRN1c8ZtvKmDrBTMlLTOa0cR2rxDHdbGDSUMGTR50BNX/gOuVuqJR2Ox
         mQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748448941; x=1749053741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+C1RzNTr6MbSo58wcEFxOVAmKna9VJA+FNUjpMEd4H8=;
        b=Ho+RuMigTDhb+PAyt4z3dZSni8dc/ZoM5aHdHVwqgNyzQRq4d8L/N4ppD+ACwF8sUB
         B8HxE1378ItHi2XzSBen9T/0UO7Ae67DLzCqtCzVf3OxuRkHg1kzP2y1pfvNdzEtXX+Q
         Q31Kx8bcq0OdG8GNjnr63OO/BXkkSvj4cBKxPmUiUtTYQJ4Qbr7QiUKapgm9C7uwr2zx
         AzTLCwg3xxj9fTRPx73dexsJ36lX8h4yM+ycpMsVgV7yJGOje1bADeBEXi+Bt6zlVqge
         Fqf/ESD72m+qa3W4Sttq+kHxZbdnYuHA6mL6S7AV0j92ogsuU01FKK0arzmcN0Uonmaz
         JjmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVklhv2GeghmjiAqUyIP7R8Wc+jN238O88mQS1XeP97E1gcXRLBQ3jQ+5+IZMX4OxrAOgpWoZo2t2c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywppr/SED/7awVzKnROLbEq0p+K9IaPyF4I4Rp5dqB6r66bjk6S
	Fl6TYdfRNABmAb+yJHNpxVviuDA7A5CztR97JLhNJsLeDZqByqtKEzsO0v5y+rOLLhU=
X-Gm-Gg: ASbGncvI27Zrox2Xsif/77dqK5lWSxGSVf/1dMutcQ+LQ9nFYSAAssxVxkqbaz/6oVC
	7N16abkJZLa7Pp1J7S+n5pAs2EUnRtRVDyToshEai8MqrTgWJfBZb5xyaR4Byqj3zTjQQIwzvSx
	DmTsrvAh14HjWSUNIdy71eIjrkb6hEqSA2nFU5qCWMEit/dqVzNRFq89JYzhdQHBwCY3vhtQEY+
	uzvdqzV1+bh/T9D/aDnWeohrLdh2mjSybyPvpU15RcnEVueXYCYo676W7l4lm4VB++l9K0C623e
	2nxsJMZxIFGDk7ZC13n/DFYq85njshbZz1NHUm2B8eTEzOPabcf/zxw=
X-Google-Smtp-Source: AGHT+IGY3B2n3dEpBIQTEIc4UcD13zJbfNxCVilIBzIvGrsLXjUktw06sdl/F0Rxa0Z5ypRV303Ptw==
X-Received: by 2002:a05:6000:2389:b0:3a4:d238:682c with SMTP id ffacd0b85a97d-3a4d2386cfbmr12567851f8f.53.1748448941430;
        Wed, 28 May 2025 09:15:41 -0700 (PDT)
Received: from localhost ([41.210.143.146])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a4eac8a74esm1859615f8f.45.2025.05.28.09.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 09:15:41 -0700 (PDT)
Date: Wed, 28 May 2025 19:15:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Shiju Jose <shiju.jose@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Li Ming <ming.li@zohomail.com>, Fan Ni <fan.ni@samsung.com>,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] cxl: fix return value in
 cxlctl_validate_set_features()
Message-ID: <aDc2qGgYVzXMSUpz@stanley.mountain>
References: <aDbFPSCujpJLY1if@stanley.mountain>
 <aDcqO5hlGrRXzIPT@aschofie-mobl2.lan>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDcqO5hlGrRXzIPT@aschofie-mobl2.lan>

On Wed, May 28, 2025 at 08:22:35AM -0700, Alison Schofield wrote:
> On Wed, May 28, 2025 at 11:11:41AM +0300, Dan Carpenter wrote:
> > The cxlctl_validate_set_features() function is type bool.  It's supposed
> > to return true for valid requests and false for invalid.  However, this
> > error path returns ERR_PTR(-EINVAL) which is true when it was intended to
> > return false.
> 
> Shiju - Can you trace this one through and add the impact statement?
> Wondering if this is going to fail gracefully, or badly, further 
> down this path?
> 

Sorry, I would normally analyse this a bit more myself, but it's only in
linux-next so I assumed no one was using it yet.  It ends up being fine.

cxlctl_set_feature() has a check for:

	if (rpc_in->op_size <= sizeof(feat_in->hdr))

at the start and sizeof(feat_in->hdr) is larger than sizeof(uuid_t).

regards,
dan carpenter

