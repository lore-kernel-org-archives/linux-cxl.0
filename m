Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DC61FF1CF
	for <linux-cxl@vger.kernel.org>; Fri, 14 Mar 2025 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741959511; cv=none; b=j944YWfnVBVTTmoijw0OCycmideYRtC0D7gNaG/rPBL9/nC4H0JTIbzpXObpdqJVBUmDHRdT5NYtILfDZsyFpHqqUhVQV0TnSHEffdgyPqCYP/mYKpTBCikjrzxr5iqECu+HTh2ZSibrzhhEcXuOqE/IPBmV35SbWeW1IgnZni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741959511; c=relaxed/simple;
	bh=dTUfZaUXUhKnc6MxStAvrcDIpBExFEEzoAT/Dkc+VrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5PBuaFKdNgyjhuR9ZIk0JozLzFeo9UYYxGvf2YjBDcYjYCC6M+3v1h+AoKSGZo4t0MYRWUM778Y1tH/PdQNiPcgfMiGLb4XC+GorTHcSvjlk7c3teBg8Zi/vjZ+OqnCWY1lNKH/7PbA0zh9TnmjCW4z1fUn2yvoCXcmcie0f00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=p6nGZVBm; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="p6nGZVBm"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6eaddbfcbc9so29782476d6.2
        for <linux-cxl@vger.kernel.org>; Fri, 14 Mar 2025 06:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741959507; x=1742564307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eoF44ugI6vP8IjcPcTkZmDI6ldOJ1uZycxinDR8ZEfE=;
        b=p6nGZVBmO0bijMurW7dBY9nfCMRPL1ayrrJ6qXySYAajiquWdM0P+oyYQCsXCR7jKj
         A7Od7FpV+Ql9MH9vpEF1V59M+7FmZF7gWY0cgBRTT0Z3lkgmNalaQGa5PLVhnBltilDl
         YQPPY+aLw12p5VxVfp0UtRWrc46Rf3tX/0SuzaHwwESYFpFrfGut37bR1WbV6nFnPIf8
         xVKWJK8BFL9eqLzTVq2N8+qTspB8hh7hIV59kcli9W/st9MLnRfQgXB3pp1TJvlW4qCB
         UMGSpSi2pfK5McPCzbg/APXYaycmxrr97AbTEAc5MXLCcCiLbFtVJPUleydn97Mt6EuP
         hOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741959507; x=1742564307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoF44ugI6vP8IjcPcTkZmDI6ldOJ1uZycxinDR8ZEfE=;
        b=q4vRPjOfPNNfa9M9Gg67njIWMYIbhW9lOLjYRWimyae1SpS2qikwgiGqkW6s6QcYXC
         QHulNS+FJLfkJF9NE1ep2tI+fXuQKM0zA6xfp82PavcwiGjzT4CwaT9zn93T/d94YCy5
         uUBzC+bajlilBlkmZcW2YuXrQXh6Lm81WS+FamlLkvbxqEZjsDCXtnS5eU2Ijq0ZnXNB
         z9K5Yelci0Uh9L+Vey8oACe4XByBiGu/WddX5VmYo7mm3+nJgHpBW6HgT31aZXgJ4r02
         b7vJ+PePkkpBcdloeAZrQleykan+oYvUeJlvz+exH9DT5O11TtUQRiUIHGcLzlbW3yW7
         xmgg==
X-Forwarded-Encrypted: i=1; AJvYcCWH4XRucJijQ2s/Wp/3OEa7sdt2nErcB6Wx00SlKaxgBlKEfjp+mgAbs3AL++GE6WXPAIEopJc/+7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXxtAeOQ1FoppHuTCKFKwDKu3sMRFHhzu9he8vvddYPjtCGQ3O
	FuGsEbI4dcc6hJRquQFssg3KI+sR6jOBvTosFogCb3qBlPFTkm9xvnMJTJ+ZalI=
X-Gm-Gg: ASbGnctr1ojDaYGl6EgCNF79rWBJ4hsEch5JwO9pQzYj7a+pqYsvyCV2H1kvXP14TFz
	cyirX4tOjV/i4PAA8RP04axAEkpkdHArjQWc+Zl88eZO2TNM1ITNnSQU22SMR1osD+xnnULQp28
	JZ97QFLQK2vm18FbMfEWJ9nWveBCNtyhxv5UBtQU9V4cSxmRlUmaVO8L9Yn21QyeH7/I4qgnIGP
	8+ge+7ylvmQlaCAdh4xG3Lzh9Nll0uavELE98M1x/WbTLxHnZull6WlA68NxQ0SBXIYI3TOgrC6
	zBE6qzUWggDB8XOL9WFb3ggVkYPixIzQyvIZPYk9u59XCoaFWiNtMDSglwYd3Q7Y1a7QRbpkVrk
	UkDAP6UKNuuk+/a/9ZDWmfZ6+sEk=
X-Google-Smtp-Source: AGHT+IEgUXDqQalq0QLNm6R9nYlOpQxNyi5UlXIxkWp5LsR9Xb92fZqa2be466apd51bhbUPRrp8/A==
X-Received: by 2002:a05:6214:b64:b0:6ea:d69c:a247 with SMTP id 6a1803df08f44-6eaea9e88a0mr39382126d6.4.1741959506662;
        Fri, 14 Mar 2025 06:38:26 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade349801sm23632916d6.94.2025.03.14.06.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 06:38:26 -0700 (PDT)
Date: Fri, 14 Mar 2025 09:38:24 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Yuquan Wang <wangyuquan1236@phytium.com.cn>, rafael@kernel.org,
	lenb@kernel.org, dave@stgolabs.net, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, rrichter@amd.com,
	bfaccini@nvidia.com, rppt@kernel.org, haibo1.xu@intel.com,
	chenbaozi@phytium.com.cn, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] ACPI: NUMA: debug invalid unused PXM value for CFMWs
Message-ID: <Z9QxUNP2aqTGpnMJ@gourry-fedora-PF4VCD3F>
References: <20250313060907.2381416-1-wangyuquan1236@phytium.com.cn>
 <Z9LzjQCKFfsdE2yJ@gourry-fedora-PF4VCD3F>
 <20250314101226.00003830@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314101226.00003830@huawei.com>

On Fri, Mar 14, 2025 at 10:12:26AM +0000, Jonathan Cameron wrote:
> On Thu, 13 Mar 2025 11:02:37 -0400
> Gregory Price <gourry@gourry.net> wrote:
> 
> > On Thu, Mar 13, 2025 at 02:09:07PM +0800, Yuquan Wang wrote:
> > > @@ -441,6 +441,11 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> > >  	start = cfmws->base_hpa;
> > >  	end = cfmws->base_hpa + cfmws->window_size;
> > >  
> > > +	if (srat_disabled()) {
> > > +		pr_err("SRAT is missing or bad while processing CFMWS.\n");
> > > +		return -EINVAL;
> > > +	}
> > > +  
> > 
> > I thought the srat was optional regardless of the presence of a CFMWS.
> > Is this not the case?
> 
> True in theory, but do we want to support it?
> 
> I'd vote no unless someone is shipping such a system and can't fix it up.
> 
> Jonathan
> 

Well, this is really the patch trying to deal with that I suppose. The
code here already states its creating 1 node per CFMWS in the absense of
srat - but this patch just changes that and says "no nodes 4 u".  I
don't think that's what we want either.

~Gregory
