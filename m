Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A471F1534
	for <linux-cxl@vger.kernel.org>; Wed, 23 Apr 2025 22:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745446911; cv=none; b=ZcCd9Gr98qGN3VEkD0dLAz0cL+MTX7IAZgyU9uIaWbKXXk3j1c0bKLznwAGrUCJHp2Unp1K6foUKoxiisfiVJX9m281HqzF4RhOW61OWe8k/r39tuPGGKWv/uOmlBq5k3bUZRaUbZIXuMQVG3hTwcVcBcBoI/KNQcA1ibtohtIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745446911; c=relaxed/simple;
	bh=3yB5m0NyUXUmVsetwBc7N61EfrdICLsTvEHds6YZI/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYIJ/i6j3Nb9bvkYggly+onRk60U1bzMGHT6RDaRNN+bN/4SvzSHUoDcnTgoTF47ix3uptj3h9V1xrAhiyTk8+iV/hU3aFZyVnpDj1GP5a1uU77UMyEmj1wKZLv+vQiabdu9mPDaQvam997AJpzhFTg0+YO7hvmgWAwWcCCUZMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=d2bBrZAS; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="d2bBrZAS"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4775ccf3e56so18208361cf.0
        for <linux-cxl@vger.kernel.org>; Wed, 23 Apr 2025 15:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745446908; x=1746051708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5F1rkWnXVQCxgZlMjPH04KG8PhXxdy/Np8jue5oE4Y=;
        b=d2bBrZASJqJ7H9kn8HiJHxvHoKLw/JetnyIYNXsUz+Dib34GzV7HT7JHl+VZq4nFZL
         ZDmtufvaQfgI3e9nFXvZt8PPjwvWeirxzZjMvCfDiqwVDuMFPH5v53o34TYJjV56COOr
         6igf9MMidpu1vptJGU0U1MsbCo4TMi0cfQ/nlh7cyrO19zDgjVgaSn+9GlNyrcZ+Au8z
         Y7ep8+colG5hw8ka5QwPr6V89xtkmsyOAyONhjj7yCteeL5SI3E0XpeAcQKT9ARvdT+J
         YNmzlvkJofE6WG+bm3xD2EQE2IzglR/4JhIFxOm2dgca4Oh2Ndc+RDwQIDThEyFVVqv2
         gA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745446908; x=1746051708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5F1rkWnXVQCxgZlMjPH04KG8PhXxdy/Np8jue5oE4Y=;
        b=Sd3BGGcY5O7EGrjxIdUIHm5UILeUxelza1Be6Gw1vbUxQw0wuLvC9hhWHYyjlxohcE
         2bCqsnxe34O/qgAAeLvbDMy5NFZ1MWvMUAfV7UW0ytWQ+5IbyRMYQgC+V1PE4fFi7yoo
         OfF0qHfmLIrh0cDyH8aJf4LIJIblRN8yBXxw0SffrwZx7B1JnZKodF+/+ifRNWuO58HE
         h9I6dLqhP/LAzgD69gDzu7H8j/Tg+t4PI2VTbspM8KnkxOVCRwmMX8he7XjtqcIjiPz9
         k+DjJ1VTEU95kINkeKI4Wqp8szACBqLMSiJRQaXLGonbf3yOBtr8fgdB6AaLK20IORiN
         aQ3Q==
X-Gm-Message-State: AOJu0YzuU3RyKr5obdEeHhz1B+x7K6tSrHYOtRIahOlarUjz9OQAnbB3
	w+ds0CK1pF1s9KlVJeGxbZEvITQmYs6MPZxx4nyHvOIGfV1/ylex9bszq44gLPU=
X-Gm-Gg: ASbGnctArT0WiDZkB7SnIPIQ97JzLSFxkxq43059oCDrtk8z1YiYUg0KNz36j1D8nLr
	PsfXPnQnME5SNSW1mggww5DTQLBmQbYs70ogdZugJFIeLZcWaqMU86/h5PteP42qpMFqs77mDBj
	QV3YiaXftfSIwhmJM+J1fBQHU7CmRKdAkkyOedOHVF8s9UL6KilSMuo6qvH4f3fPUik7QiQ5C6c
	rtc950Ueb3C5JBhZd/h/Qh8M64A2HmnxGR2hFzQv0xnZe1gRbiggqIwc6NIEqs1lptcwg67oNcc
	4bW0g0iHxKdmUPIHNeOkSLr4xrRGfIIY84sMd2McW3yWfW5ZrjYVdPzJij3llPq7drN+sJqfhUR
	TWOjJbjpkelSQswOjU5bd28k=
X-Google-Smtp-Source: AGHT+IHvLKmVbePb7fXOjg/ctNGWVxPz5bpBsO6AskThbz6jfaCCslzbr34ZGd4Tr3a19V7j4alfrQ==
X-Received: by 2002:a05:622a:229d:b0:477:1126:5a33 with SMTP id d75a77b69052e-47ec2b56ba6mr604641cf.1.1745446908445;
        Wed, 23 Apr 2025 15:21:48 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9bd6c1cbsm1927781cf.0.2025.04.23.15.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 15:21:48 -0700 (PDT)
Date: Wed, 23 Apr 2025 18:21:46 -0400
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v8 04/16] cxl/aer: AER service driver forwards CXL error
 to CXL driver
Message-ID: <aAln-k3lQnylTFvV@gourry-fedora-PF4VCD3F>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
 <20250327014717.2988633-5-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327014717.2988633-5-terry.bowman@amd.com>

On Wed, Mar 26, 2025 at 08:47:05PM -0500, Terry Bowman wrote:
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 46123b70f496..d1df751cfe4b 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1123,8 +1169,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  
>  static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>  {
> -	cxl_rch_handle_error(dev, info);
> -	pci_aer_handle_error(dev, info);


This appears to remove that last reference to cxl_rch_handle_error,
build throws a warning saying as such.

I see in patch 5 it's removed, should probably be removed in this patch
instead.

~Gregory
