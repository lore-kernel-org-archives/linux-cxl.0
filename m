Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E9C38734D
	for <linux-cxl@vger.kernel.org>; Thu, 24 Sep 2026 05:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790226105; cv=none; b=twqQb19MC1i2K71xTciCIY8iwtNSZmAZ8GD/qWVGB6D2ujes7bpR14D0auU5sZq8RK2djoAcV4hT4kqo5p77h7jPJKJQPGvYg4NMLHi33qiMZZtXWkzb5XzI5QXZ1zhIMWwznl4b1Lqh4oQAy6toDEt4JRJJVNRQS2/EgZR3ixk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790226105; c=relaxed/simple;
	bh=exBL9U2/EzwsMI1TQjTIO+ovhJC167OFGQgAU32+kC4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MdDa8XtJ0c0aSs7ozCkDFIzhPC1crPD5f9As2iI9zgr3QdIMIvc2kTE1jfN2sbuSiyJug2kdBmGL869dO7hoFMriKysHb47vZGGnV69/+aWqJmjDr/x0a8QnVFCjWEuHEUk8WaemtyIq9j6dBKsvwlVhSslGDVsuooBK3uz203U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fvco6ElF; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fvco6ElF"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-3396cec93b6so1736719eec.3
        for <linux-cxl@vger.kernel.org>; Wed, 23 Sep 2026 22:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790226103; x=1790830903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xx4Ce1Ds4QfgLhfTkQIEn2UYbIhZsI/9BFplLJBpe6A=;
        b=Fvco6ElFJamKrxKGx6SqMpGh1VHm5Oj4wrl5e0b7AkHAXtPtAMI+DZeEdnqqNp+8wK
         2dSYCnlLVnXSbDlE1ExJjaJv3ENU6rgiJh79p31n7yD2yvkHAqIg46W6uzJzU8CKyTt6
         OiQ7iDAWZHlDrkKoVtsYdb0LsNHnpPk6S91hvMWK6FnrIWYnquIzdn7hV0ppi7yr96im
         Y7vaNGSfMxJKjxFJ8E/xLG6ELhBQcuccspAu/ZGJIYOo2gidBrxCKCMcKbceHKoztr/E
         QLAWX6kqI+iIsIvcQcsUDiV6pe/nyIcnvM660lcarzbmvfWchs78DotsXeooviH+/2Y/
         +6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790226103; x=1790830903;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xx4Ce1Ds4QfgLhfTkQIEn2UYbIhZsI/9BFplLJBpe6A=;
        b=faiX+uS10uKXaVmy8GzUBAcfQruH/HetiVuWcFGQ3ImnLAbZirN4N4drmCgKkYsxDf
         83RwmFWeElsBE7gEG64ONCgEu080p6wnzbcX/ScthYbiOsjEvZwH474yoxE374Ft0MZx
         o0zRXiIG3FEBEKUUBbvRMpUgMBAnYR5DupMyPdY12wszt+yyByXujR+pZa9tr7suqpfT
         29Z2h7KmwW8nIP6F9yyh3vuiF+b6eyI6xTH9ZBTfg01Uxt/1TMfvir+J4CUjSoEHUJmX
         XDG67PNVMlIrZFBxIrBC110hSnCZXzT4W426pCAKLPYUdsFbhWUhFTi6xfHvAv9TnjTI
         dnUw==
X-Forwarded-Encrypted: i=1; AKwUvBwcbpULsAVi3IqLJGBlWVdx3jY3ZFFjbsBy21oR/QUkt58gyiU1npxgkgmsLKpvICt6pjS1Vzugmu8=@vger.kernel.org
X-Gm-Message-State: AFuF++k08K888CLUSzWC8M7LAeauIkD4XkwkF9RlTnifJCDO0Y0Evl1z
	e83AOgQORFwSO0kvKi3NQlvvyEOQMDl+oYMEUwWECBwenuCqtUpj1Dgh
X-Gm-Gg: AYBFou3KeQAeUAgQmBOadYQRKyldOKMreClyRLk8xSC9BRqQn7vCEgqsKcsVT7QnW36
	RizmyzqB10AjdYl7Ae0SAb1GvKSOEfVfqlf63DD/ZVRNLh1tBwUr4woAvg1CIsbLovlyJNo6b/I
	6Hehe2EjKXfkAKpEZw9ExKYy9xfZocMn+JySrHYk3/kr8Lyz5bTuBgjGOxEdXcItS40NcWW6J32
	SgcK5VLPGYnh/AqHju5EAODkEFtUpVV/v1OKEoupwQY/jesDh/7OnAE6pOMrP18Zgv5cEhniqpG
	ZPHEBppRfiJCs8+k1XQuw26Yf3L6+LTENmhDunFxdvkJqjkF7tD0KwfDWSlc1GowErH3Eqyb+zm
	dLCShSqLec7lnHMVyV9Dj79OMUSSSmV9i1v3bbWIJGk7DcBlk0Cy+zT/m/HsAS9w4N4hNG3cwwg
	XGXci1baWYL+OmXlBH2Lm5+r6HEumugV49QrNmL4tt68MSkwNdgfSwUqoGJ6fhAySAY8W5ckbW/
	525i2Ba5T5d5h6pcLHcUXqavAQSptORxdixGnpfHyXUSKxbxFrtFjnEtUrWbaZhCOlCJ/WtZ9u2
	G7J8gg1OBBPVLdfW9Q==
X-Received: by 2002:a05:693c:41c5:20b0:33b:a4dc:d5e1 with SMTP id 5a478bee46e88-34000f38375mr965817eec.8.1790226102661;
        Wed, 23 Sep 2026 22:01:42 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e939fdd91sm10958724eec.4.2026.09.23.22.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 22:01:42 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 23 Sep 2026 22:01:40 -0700
To: Jonathan Cameron <jic23@kernel.org>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Li Ming <ming.li@zohomail.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>,
	Ira Weiny <iweiny@kernel.org>, Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [PATCH v14 3/8] cxl/cdat: Gather DSMAS data for DCD partitions
Message-ID: <arSutPdVYgWz4tIe@4470NRD-ASU.ssi.samsung.com>
References: <20260918203049.7273-1-anisa.su@samsung.com>
 <20260918203049.7273-4-anisa.su@samsung.com>
 <20260922002743.4b80425a@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922002743.4b80425a@jic23-hlaptop>

On Tue, Sep 22, 2026 at 12:27:43AM +0100, Jonathan Cameron wrote:
> On Fri, 18 Sep 2026 13:30:12 -0700
> Anisa Su <anisa.su887@gmail.com> wrote:
> 
> > From: Ira Weiny <iweiny@kernel.org>
> > 
> > Additional DCD partition (AKA region) information is contained in the
> > DSMAS CDAT tables, including performance and shareable attributes.
> > 
> > Match DCD partitions with DSMAS tables and store the meta data.
> > 
> > Signed-off-by: Ira Weiny <iweiny@kernel.org>
> > Co-developed-by: Anisa Su <anisa.su@samsung.com>
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> > Tested-by: Junhee Park <jh9934.park@samsung.com>
> > Tested-by: Heesoo Kim <habil.kim@samsung.com>
> > Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> > 
> One little thing inline. Either way
> Reviewed-by: Jonathan Cameron <joanthan.cameron@oss.qualcomm.com>
> 
> > @@ -419,12 +443,13 @@ void cxl_endpoint_parse_cdat(struct cxl_port *port)
> >  	}
> >  
> >  	rc = cxl_port_perf_data_calculate(port, dsmas_xa);
> > -	if (rc) {
> 
> This ended up a bit nasty from an unusual code structure being less
> readable than ideal point of view.
> 
> > +	if (rc)
> >  		dev_dbg(&port->dev, "Failed to do perf coord calculations.\n");
> > +
> > +	cxl_memdev_apply_dsmas(cxlds, dsmas_xa, rc == 0);
> > +	if (rc)
> >  		return;
> > -	}
> Can you make this
> 	rc = cxl_port_perf_data_calculate(port, dmsas_xa);
> 	cxl_memdev_apply_dsmas(cxlds, dsmas_xa, rc == 0);
> 	if (rc) {
> 		dev_dbg(&port->dev, "Failed to do perf coord calculations.\n");
> 		return;
> 	}
> 
> or just duplicate to keep things simple to read.
> 
> 	rc = cxl_port_perf_data_calculate(port, dmsas_xa);
> 	if (rc) {
> 		dev_dbg(&port->dev, "Failed to do perf coord calculations.\n");
> 		cxl_memdev_apply_dsmas(cxlds, dsmas_xa, false);
> 		return;
> 	}
> 
> 	cxl_memdev_apply_dsmas(cxlds, dsmas_xa, true);
> 
> 	...
> Second one probably a little better as keeps messages i order if we
> happen to get a print from cxl_memdev_apply_dsmas()
> 
> 
I can apply this with the whole DSLBIS business discussed with Dave and Richard
in the other thread. RIP review tags... :')

Thanks,
Anisa
> 
> >  
> > -	cxl_memdev_set_qos_class(cxlds, dsmas_xa);
> >  	cxl_qos_class_verify(cxlmd);
> >  	cxl_memdev_update_perf(cxlmd);
> >  }
> 
> 
