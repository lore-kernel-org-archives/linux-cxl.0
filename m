Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EED237154
	for <linux-cxl@vger.kernel.org>; Thu,  9 Nov 2023 19:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIy5+noh"
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940203C0D
	for <linux-cxl@vger.kernel.org>; Thu,  9 Nov 2023 11:58:37 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7af20c488so15933137b3.1
        for <linux-cxl@vger.kernel.org>; Thu, 09 Nov 2023 11:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699559917; x=1700164717; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yyl6INtqHNJ4WnREJbikqO12UlCZNwhilevTx4TD7qc=;
        b=EIy5+nohDZaR3uXFde6jIIOs3Ie9REhhoasQ0PEQYbP/remQOVLBk9I2OQJeEaOcxV
         NOkI2WWqv7hez1rOhrQvakFk2DC474wSJSmNirpi5Rfauv44TMTC4VcxhkkHB9Mj5wuL
         ge5Cq9BpwRlM3u/UgLVdqH4Feb1uUXkY5w7N+8Gq0IGPeYgHHM3H8Rl8gnxc0xYGKnpZ
         S9DymppGsOsuJ/sXBiLtKaXdZ5pzZ+uHfVeclTlURFSuFJYAR2vdJl2hf/wfJqDFEPBK
         PKgooXvN6CngfqQtQ0cLSh/k0/++mYhDhgUIAVkAdS25WqvDrx+Wu0wS/t1YwGaJXZTp
         15+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699559917; x=1700164717;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yyl6INtqHNJ4WnREJbikqO12UlCZNwhilevTx4TD7qc=;
        b=Y6UKXEXIgzjJfevkK7jGUhHttm4G0usHqU14vCuV8qdiGMuMV0H7NISWfigpfLrrY+
         CDRi0jOG+1biRJjhENmphjF+2h15ZcjOHAOaTmUucgcTz6qVf1U8J5IK5HQ/4ZhSLUp+
         kJsPHLY//cD9L1jEAf6OecpctIDjGFsXpNf0H7tLxP0xL7ONWb3AFpUTSRResz1ZJh1A
         uTx0d3y4xFweR+pUoQMeo2rA/DOVvqhJ9zEMBkkzT4sUs8lJI9HDdelzHAKEyGXolo4E
         M/huoVhPH6eMyoGlk/hvXz/WHbCdY8iLRaz9A4iufH7fzKn09GF7NYdtuoMhrdI4iw+B
         fHhg==
X-Gm-Message-State: AOJu0YzFNBTvPDp46u6xZN4xmyqTxtgtqC4/kKtg8ujzCAL4U/tp53a2
	uymuhYgd3PahpoER8ox2pVY=
X-Google-Smtp-Source: AGHT+IE7F+BZmzB0Aur4ZHmI2ATeFw9gYPCepRCYGcWJcNaKmdBpTAmT0uCNYkWLPeQUQWcAa2TrmQ==
X-Received: by 2002:a0d:d996:0:b0:5af:66e7:e382 with SMTP id b144-20020a0dd996000000b005af66e7e382mr6894247ywe.34.1699559916660;
        Thu, 09 Nov 2023 11:58:36 -0800 (PST)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id h13-20020a81b40d000000b0059b2be24f88sm7982204ywi.143.2023.11.09.11.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 11:58:36 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 9 Nov 2023 11:58:19 -0800
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, dave@stgolabs.net,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com
Subject: Re: [PATCH] cxl: Add cxl_region_rwsem around commit_end write during
 decoder enumeration
Message-ID: <ZU0525jPfkigOT01@debian>
References: <169948110840.509375.13862681045079385425.stgit@djiang5-mobl3>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169948110840.509375.13862681045079385425.stgit@djiang5-mobl3>

On Wed, Nov 08, 2023 at 03:05:08PM -0700, Dave Jiang wrote:
> init_hdm_decoder() modifies port->commit_end without taking the
> cxl_region_rwsem. An assert splat emitted by cxl_num_decoders_committed().
> However looking at the code, it looks like the write version of the rwsem
> needs to be taken due to the modification of commit_end. Wrap the write
> version of the rwsem around reading and writing of commit_end.
> 
> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/hdm.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index bc8ad4a8afca..a8f960c496cb 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -854,10 +854,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>  		else
>  			cxld->target_type = CXL_DECODER_DEVMEM;
> +		down_write(&cxl_region_rwsem);
>  		if (cxld->id != cxl_num_decoders_committed(port)) {
>  			dev_warn(&port->dev,
>  				 "decoder%d.%d: Committed out of order\n",
>  				 port->id, cxld->id);
> +			up_write(&cxl_region_rwsem);
>  			return -ENXIO;
>  		}
>  
> @@ -865,9 +867,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			dev_warn(&port->dev,
>  				 "decoder%d.%d: Committed with zero size\n",
>  				 port->id, cxld->id);
> +			up_write(&cxl_region_rwsem);
>  			return -ENXIO;
>  		}
>  		port->commit_end = cxld->id;
> +		up_write(&cxl_region_rwsem);
>  	} else {
>  		if (cxled) {
>  			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> 
> 

I have two questions:

1. There are some other locations in the code where commit_end has been
read or updated, and not guarded by a lock, for example in
cxl_decoder_commit. Do they need to be protected by cxl_region_rwsem
also?
2. Can we have a race condition here in init_hdm_decoder so commit_end
need to be protected?

Fan
