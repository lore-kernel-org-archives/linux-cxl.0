Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B9C1B3727;
	Thu, 31 Oct 2024 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730390444; cv=none; b=O9lqyzsxodxoD+ekVkRJRzIpy6QPigUlcP34+twHfV+N1tpy2o0buHIF+DAEg2Jff+xGpgwwHQ5hueTvQjd5ii0b9RZ71KTDTuHMf847q+AiFFqvLzfqQJhZ0n4QajNCzjLH+ACj3yoNJbgtAXDdSXRTX/joqc6/NZBrmUpyQFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730390444; c=relaxed/simple;
	bh=tzGE177RLHryW3K1wOEfN8lfRCPGCZu9JmmGUyvowHc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXSrCaM3GAqSNxZMTw4lfYTS4BJUuQQmCnNXYEJw+t/ksSkNKxicTgZrSPvdSjjx2TUDXNfpBxaU7JdA6pAKbDSEHd2t65WbvkwSnHv4FoxevfL9ice3sr7jq5vop2mVs3EZKT4+7YHqUmkfNoMxMJVFNQQKj96MjZZelvVCT/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1L7DxIq; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1L7DxIq"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ed9f1bcb6bso821958a12.1;
        Thu, 31 Oct 2024 09:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730390442; x=1730995242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uGOII5KIoNBsInbqpRl52akNzPjgV4X/atjPgk2L0S0=;
        b=a1L7DxIqv09I6tzVqmDEw7KqFAzs8I1sl2j+iSop3V/FgL7AVxqu9SgN1jz/osCfhY
         zBGdWVxLMf68GGrSqa3DRWJWF5OpwRTgropT9uSqCo/Gk7bkqDOlEMr+Wnd4xE91TCBv
         pJdnjPUWNZQJaNlUCAJw1mhlc107uYQpehFXd2lRDZMywCAHd5dCnz/9/dvJouiPgwrN
         Kb6I9kV1js7JNwVdtHFz+6vuK3uduI6WtbgIUcu4T3c7Zf8rbl7tPWGSGxs5+zrea1Lq
         ePOuyseDA87Bxb2Hx8mV3kNfwsx8gKx1SeMtjWFMpheL5Q3i2yJbkuVSjjusSfEYap5A
         5dfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730390442; x=1730995242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGOII5KIoNBsInbqpRl52akNzPjgV4X/atjPgk2L0S0=;
        b=PeBrIwQWabSSWf3e9M5gZIAS/6jZ/JnxK6Fw/usmFnEbTPxjUTzb656OFwoU+Hpk12
         4X7uJX2YlZNDbB/54ivpiay0h9RrUpxxAP5cAvojuoFK4z4ULQYUiJmm2NDshRgalJvb
         tHUJRvz7vo59U6nwRiyOr6YC87gC+uGmsAduiqd7vIPEyLX7G6V1svzXPHHwtcpkJff8
         LZDglz3WY32rJwFwy5vhGdsIIwHVjH3TRWI1XgHiJFqhsTQuse1UJqBrRAApX8b/hWSR
         QYtCY8G9yb9xtd0lEFvlJASYOu+15sKbAdRy3l0SJNemZdHIwFGha2TKS8YvC3WKkD8C
         HuMA==
X-Forwarded-Encrypted: i=1; AJvYcCUzW5yeLmwzCZZnx58Gla+s3IfHrDS7pqaejyjcDycPkGNMclMSw8X2gPRwCpu23kwysU6gh5+WKeJZ@vger.kernel.org, AJvYcCVM/5p8tC4MYfO6F7KaDY7xAqhiA1fBHdGKRN49cA50J5FWe9u25nhV8lq7hFYFSNNEueRmqe8aQ3E=@vger.kernel.org, AJvYcCVsJuLfGrzXe3/ZdXiLiCpEWaihRd/PY6RJ1KyvvJP9GueJfQlqli0887d2Xnu+josAJegUldcAM62iss4CuRn8@vger.kernel.org, AJvYcCXAKWom5uOx3IzUuKuXAopmkYfOfP39RXBRcZug05/Im3gVdV16Unh1bSUZRhzQrBdrWxAV3OmIFKBfzoo5@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn7FpOkzHkyV6rD/YUMVWD6cc+kIFwHIww9ZTyHQKpH9+N+qS3
	DHXELn3guU1+ZbOmp9SyzyRVM9UgFQm3qX/FAmLRd5SKj4KaPzXG88bhLA==
X-Google-Smtp-Source: AGHT+IEZxzYcoAhXfDOCE5PcQurxLpXSUsNhIhkZfiGW5USQnME/GkuMHGv05NbuLGuW13HRjlUd8Q==
X-Received: by 2002:a17:903:1108:b0:20c:e262:2580 with SMTP id d9443c01a7336-210c6c3ffb6mr216530145ad.44.1730390441822;
        Thu, 31 Oct 2024 09:00:41 -0700 (PDT)
Received: from fan ([2601:646:8f03:9fee:1a14:7759:606e:c90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c083fsm10264155ad.187.2024.10.31.09.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 09:00:41 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 31 Oct 2024 09:00:22 -0700
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: ira.weiny@intel.com, Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 08/27] cxl/mem: Read dynamic capacity configuration
 from the device
Message-ID: <ZyOplknEK6XkqE1Y@fan>
References: <20241029-dcd-type2-upstream-v5-0-8739cb67c374@intel.com>
 <20241029-dcd-type2-upstream-v5-8-8739cb67c374@intel.com>
 <20241031013441.tsuqkrbqbhwsv2ui@offworld>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031013441.tsuqkrbqbhwsv2ui@offworld>

On Wed, Oct 30, 2024 at 06:34:41PM -0700, Davidlohr Bueso wrote:
> On Tue, 29 Oct 2024, ira.weiny@intel.com wrote:
> 
> > +/* See CXL 3.1 Table 8-164 get dynamic capacity config Output Payload */
> > +struct cxl_mbox_get_dc_config_out {
> > +	u8 avail_region_count;
> > +	u8 regions_returned;
> > +	u8 rsvd[6];
> > +	/* See CXL 3.1 Table 8-165 */
> > +	struct cxl_dc_region_config {
> > +		__le64 region_base;
> > +		__le64 region_decode_length;
> > +		__le64 region_length;
> > +		__le64 region_block_size;
> > +		__le32 region_dsmad_handle;
> > +		u8 flags;
> > +		u8 rsvd[3];
> > +	} __packed region[] __counted_by(regions_retunred);
> > +	/* Trailing fields unused */
> > +} __packed;
> > +#define CXL_DYNAMIC_CAPACITY_SANITIZE_ON_RELEASE_FLAG BIT(0)
> 
> Fan, is this something qemu wants to support?
Currently in Qemu the flag is not used, from emulation perspective, I do
not see a good reaon to support it for now. Maybe we will need to support it
later when we consider security?

Fan

-- 
Fan Ni
