Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279BE262FEA
	for <linux-cxl@vger.kernel.org>; Wed,  4 Jun 2025 06:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749016908; cv=none; b=oK8YGw5s+iT4abTUuWj9L0e4pOMVNV7ij6WjiJub18AQhKlUhxoS+sDOfc/hhWtQLpipfLu9MaQRDaZ+gXRj/XMyCnOAl0jVueePJbuBlHz5ZhXLMviYc4qu8H0MVci2p8rooDJNn1RSW/ivmfjqImJoru9gsTQ6swcuTchIPYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749016908; c=relaxed/simple;
	bh=OTfj5VgHFZ5gbh9tkYj67lK1g1D5j4ylUMJ/45wngNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/iG5fitxNCU0xgbT0glp06IzaBWpQ2Q1Ofwhrd68HwuB/FFK74RxL7efhopM9P7bl2qLuc5Q73zgWAXE2z7FtykrGj8655nt7kibQoUpv/y3/Hx47FlWoxbH7x0y9+CrktFw7OM9wVmus2iSMqSd3xzFwF6CTM+maKcwra7qa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IelnpEic; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IelnpEic"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a3798794d3so5337284f8f.1
        for <linux-cxl@vger.kernel.org>; Tue, 03 Jun 2025 23:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749016904; x=1749621704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=js3ePkAFRXu2bd4kJEDMYhddIA3XtbtOgMVgKzlYv50=;
        b=IelnpEicNQ8mjcrzJGFV7DLQVuoojkiEqIgUF+Nuxo4MTV1TYP7XtHh4LyrqVGiOvY
         XF+C3v3QofQCSlDFeW/nz5nJCcvELjORNfYfqjtkKvYZv9IWKzezJpCltKn4GV1iWnog
         rWkQkO3hAxNRzhiZV8sBr63LBFsFL87v/5TahTkzbPy63uHR788zaTJ5TOhffRV/t7Xz
         gnha9wL/aqQe68Z5GCYXBJk4w8f0++5w/geuXqX9OQhn5v6yfk5xFEhCnf/biu1tmwZd
         OU4NEaeu0cOhmwpyGpaJ6NFHX9cL98ls6tJmkSzOdepfTL4iMM5oRgXE5QXc9+yWuovq
         2XLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749016904; x=1749621704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=js3ePkAFRXu2bd4kJEDMYhddIA3XtbtOgMVgKzlYv50=;
        b=PGz5sphRENjJsU9OoHIJW0ei5NMmc99glHrnyOYVX8m+91MXveVpNyeWALumzVzaFO
         Ccl7q++4+wYSx+2SUahMSS3OT0Roebg/7fWyyqawPxknKCi5tlI54GUziGD6b57adrs7
         hhoNwMA6iJkHwaSxHxvgm8LN2Tc0LEwsCh3KWwWQDyeyz5LwYnOyluvoagn5Fl82YwPp
         Q1XYASI7XdChf3zaeWS4B95HSDV4gD5pHPzncnYfAhnatY28LcTXUG571djVcM7kU0Mg
         GUxRnjNjJucnbFcJOkHGEhW/LMmS4OMzIV6pob8qjlIiZYiIHG9QNwJ0dGoJ/97PjAWQ
         TEmw==
X-Forwarded-Encrypted: i=1; AJvYcCV7rSvMi+xQO6qS3gbXndxTAL1LoLXs2R8y+vloQW9D0i6QmhErL7F3/UGyfwAUpA/QYeXvbzCGtSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwdQczWucgobjp+fyLYDVc5ONfybRfut12WfMQLG0oJ93cqzZA
	cnnQRN9brCAsEomlJiobxEJcrEohbKxwXdEbHf461PwvsWMB8r53/930ZsY9Am9rKF0=
X-Gm-Gg: ASbGncsC9kKwy5S2ccL0VI9Fe/Ik8T5Q0hJNnSgusX81LlbUkuG9Gb2S/JrePn4EQmh
	xd9qWusdHTeI8nk8JJaZzEba6H37sg7hWAY6zn2hfX37AG2pFObEIME6ZhKa9LVmr/WMUp4IhLv
	ckM9d8J3g9FFjcG+TGAy5TqNeQP2u9Q6LvsdhuQ2UpA8D48p7myrkRIXMg3/V30ojWk7aGX4o+p
	/DJTkNRkqXubihP59PjqS8ePlXJn8Y7jahmEHj8jISVx7oZRJBUVkN9RSgmWm3xd++By/ZzockY
	NzhGz7AOzWsiP6CCpNi13kT+9ZzCqhg9OHVNa659BeedWLXWYkr7DvvGxYSQct4QrdA=
X-Google-Smtp-Source: AGHT+IHggEMVfIpJ7Xv+hdE4EzIhRVMoFlT3x2R6JtIQQe6ubsLLxsK+lqCkT6TBd/hsKH6MzgQovA==
X-Received: by 2002:a05:6000:2082:b0:3a4:dfa5:325e with SMTP id ffacd0b85a97d-3a51d8ef828mr998998f8f.10.1749016904364;
        Tue, 03 Jun 2025 23:01:44 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a4efe6c9d4sm20798221f8f.38.2025.06.03.23.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 23:01:43 -0700 (PDT)
Date: Wed, 4 Jun 2025 09:01:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: PradeepVineshReddy.Kodamati@amd.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
	bp@alien8.de, ming.li@zohomail.com, shiju.jose@huawei.com,
	Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
	yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org,
	colyli@suse.de, uaisheng.ye@intel.com,
	fabio.m.de.francesco@linux.intel.com, ilpo.jarvinen@linux.intel.com,
	yazen.ghannam@amd.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v9 03/16] CXL/AER: Introduce kfifo for forwarding CXL
 errors
Message-ID: <aD_hQ7sKu-s7Yxiq@stanley.mountain>
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-4-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603172239.159260-4-terry.bowman@amd.com>

On Tue, Jun 03, 2025 at 12:22:26PM -0500, Terry Bowman wrote:
> +static struct work_struct cxl_prot_err_work;
> +static DECLARE_WORK(cxl_prot_err_work, cxl_prot_err_work_fn);
> +
>  int cxl_ras_init(void)
>  {
> -	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> +	int rc;
> +
> +	rc = cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> +	if (rc)
> +		pr_err("Failed to register CPER AER kfifo (%x)", rc);

This shouldn't return rc;?

> +
> +	rc = cxl_register_prot_err_work(&cxl_prot_err_work);
> +	if (rc) {
> +		pr_err("Failed to register native AER kfifo (%x)", rc);
> +		return rc;
> +	}
> +
> +	return 0;
>  }

regards,
dan carpenter

