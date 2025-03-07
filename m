Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E4A21C185
	for <linux-cxl@vger.kernel.org>; Fri,  7 Mar 2025 15:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360085; cv=none; b=urgW1GDhgL6n2+wgfcBUnlE/BNIrlVV3M5TfSTqZ1TL619R0xTUF2y1GeYrVjxdc+/uxZ8rBr/FsN6AouFKVUpTrp1GzdnS07/f2LANvq3nHDn5CXGNZg/KcwFRV/Snedq/LNd9ofZlUg5zF3HYp5mQvPtr2O1ipEiP22Dx/2GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360085; c=relaxed/simple;
	bh=1J/ql49X6Ezkg4wdoqe/stSQpbv40JqkSw4Ir5aIPhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+a/fHVSA8y7te1wjABtAsxHpf2oYvTQb0HK6nQwSlc0klHDYBi67U2dB96p1Je4RE9lZaCP/1cpmxUIRhw3WfEaEiv/OTqH9ndD6da9BjfgVaIr75ctrAZtvLA4eewjRdyE7JO15DUqBQnECVkFpoVYLc2z+vpbje5Bi1+S5DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=UytmtL+R; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="UytmtL+R"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e41e17645dso17540516d6.2
        for <linux-cxl@vger.kernel.org>; Fri, 07 Mar 2025 07:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741360082; x=1741964882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AwqxWi0iWrXCwX2xmbnqF8uYYDlpSjPvCpbbjIDyPjI=;
        b=UytmtL+R6s5NNmC0nGk7OLaoQw/wzi+qRAjNsvG/pFGvjbwlVQTyQxLbIVowUCfYEp
         NmSp4IzQRN7BxzDdCTGU5S6QGVf6co6exRSWL8u6HIa/unBFHh2CDifmBwFNPmuu8abu
         gst5Cxpga6TRvn5bl9/vzblDpm/xvWtEvr8CjpfDjFAkC7853Ys8UIlhed9Y+NSMALaq
         Y1XrJ2r1FSyHq/R8ZyCG0sdtgxb20B8JJ+pE2lXPdgHuxWw41drGMYpsuGkKEzhDxPAT
         CvtOVRVUDEXfegow0GA1V8FCbzoGfzpfmXOwMG/FmKf1alWL8WhoCoT/opzmo8urmEga
         /uLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360082; x=1741964882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwqxWi0iWrXCwX2xmbnqF8uYYDlpSjPvCpbbjIDyPjI=;
        b=tM78ciPqRmRIv2PucjcmeVJBA5536xNBr5UaZUWZR3aWYVWmfBTaoAWiLPlWRQWkBR
         j1DyeIH7QIRtBivXj+i/r3q78GiuF8gz5KdMx1AQ5LOxaecEVFKGDfJTJHOMqhpO4/RN
         IFemDIfJm9232YreMMHeV3hqEDbyyj1UtEvGAoYinZVS0fJYvHWhc7CZRyvDhpXKfUJs
         LRbXLDqCgFVCKgYTIqVN5RzX23ZlCSbhmQYaNguT5kPLSWS024SyhEmhvQiCauOfjRdM
         7DKhpU64s3MeMcGgl7htcn1fwUkBNaQWaOfDL3A45DCOm/Sh/wD+bahmM9Ez32/H6VUB
         Cv4g==
X-Forwarded-Encrypted: i=1; AJvYcCXJ8kMUmzRBAJlDZdzyasFTPkdc/ivQvogYSm4GAIICnA7xfNrVrG+x53DZQBDRplB8kzfvQKZTeQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSpKZ4FEFk6lTfdanBVsIMVTWcdh+ZPqMzw+iadnerlSlWb4PY
	3CQMF8TaWjjg2ueQZhG938y58dc9t+X6lt6BGvD2NZRpNbPcVree+1naUd8I+DU=
X-Gm-Gg: ASbGncsRONEvsSYfPCrHUh+FX3zhCF9Fosh54+WAsVD4zCgmnw8zp9twUttfIecWSOm
	obZh6OElSLH7Qbxc5XCAkzm5JdWJlLQ5FPkf8mp7u2RuSDDWzb+iP/QIPh48+JoZ0sCmmCgfs1q
	+VL888SX8WFZ76DN0Hm+mrjjXTFVnsrfLJv+XpH7UWrr2hGaJ/bVX0C6JGAeGB3sD1shwzjhROb
	kDub5CRbkCAUHoAqdV2vS1XawAeplUrUV1t840khNgda09pr34h5DVus+8YvEh3k9zITMydwJY1
	g/Q9c9haOjKdJF5CQ47zTUmWo5IVuBz3fxF8oegmeA6iYy/F179s7ttiolUIhdqYjIoG5unTmUm
	ISzTno4orkjhMo/Xz76Z8Ljd950I=
X-Google-Smtp-Source: AGHT+IHFXN/P02s1v98zyEbqxwhlOPUAeqTTE2dEMUqC5SvXHpnKWulc9lagDpP21FJm9Hmt5sZqBQ==
X-Received: by 2002:a05:6214:daa:b0:6e6:646e:a0f8 with SMTP id 6a1803df08f44-6e9005f899emr45138866d6.16.1741360081484;
        Fri, 07 Mar 2025 07:08:01 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f70a447asm20414876d6.54.2025.03.07.07.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:08:01 -0800 (PST)
Date: Fri, 7 Mar 2025 10:07:58 -0500
From: Gregory Price <gourry@gourry.net>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: CXL Boot to Bash - Section 2a (Drivers): CXL Decoder Programming
Message-ID: <Z8sLznxBkJHWeTvQ@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z6OMcLt3SrsZjgvw@gourry-fedora-PF4VCD3F>
 <Z8o2HfVd0P_tMhV2@gourry-fedora-PF4VCD3F>
 <570b18f4-3790-4e57-8d80-a5301e5d8af2@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <570b18f4-3790-4e57-8d80-a5301e5d8af2@fujitsu.com>

On Fri, Mar 07, 2025 at 12:57:18AM +0000, Zhijian Li (Fujitsu) wrote:
> > In section 2, I referenced a simple device-to-decoder mapping:
> > 
> >      root    ---  decoder0.0   -- Root Port Decoder
> >       |               |
> >     port1    ---  decoder1.0   -- Host Bridge Decoder
> >       |               |
> >    endpoint0 ---  decoder2.0   -- Endpoint Decoder
> 
> Here, I noticed something that differs slightly from my understanding:
> "root --- decoder0.0 -- Root Port Decoder."
> 
>  From the perspective of the Linux Driver, decoder0.0 usually refers to
> associated a CFMWs. Moreover, according to Spec r3.1 Table 8-22 CXL HDM Decoder Capability,
> the CXL Root Port (also known as R in the table) is not permitted to implement
> the HDM decoder.
> 
> If I have misunderstood something, please let me know.

You're indeed right that in the spec it says root ports do not have
decoder capability.  What we have here may be some jumbling of CXL
spec languange and Linux CXL driver language.

The decoder0.0 is a `root decoder`.

The `root_port` is a logical construct belonging to the CXL root

struct cxl_root {
        struct cxl_port port;  <--- root_port
}


A root_decoder is added to the CXL drivers `root_port` when
we parse the cfmws:

static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
                             struct cxl_cfmws_context *ctx)
{
...
        struct cxl_root_decoder *cxlrd __free(put_cxlrd) =
                cxl_root_decoder_alloc(root_port, ways);
...
}


And the `root_port` is a port with downstream ports - which are
presumably the host bridges


static int cxl_acpi_probe(struct platform_device *pdev)
{
        cxl_root = devm_cxl_add_root(host, &acpi_root_ops);
        ^^^^^^^^ - Create "The CXL Root"

        root_port = &cxl_root->port;
        ^^^^^^^^^ - The Root's "Port"

        rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
                              add_host_bridge_dport);
        ^^^^^^^^^ - Add host bridges "downstream" of The Root's "Port"
        ...
        ctx = (struct cxl_cfmws_context) {
                .dev = host,
                .root_port = root_port,
                .cxl_res = cxl_res,
        };
        rc = acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, cxl_parse_cfmws, &ctx);
        ^^^^^^^^^ - Add "root decoders" to The Root's "Port"
}


If we look at what a root decoder is defined as in cxl/cxl.h:

 * struct cxl_root_decoder - Static platform CXL address decoder


So this is just some semantic confusion - and the reality is the driver
simply refers to the first device in the fabric as "The Root", and every
device has "A Port", and so the "Root Port" just means it's the Root's
"Port" not a "CXL Specification Root Port".

Whatever the case, from the snippets above, you can see the CFMWS adds 1
"root decoder" per CFMWS - which makes sense, as a CFMWS can describe
multi-host-bridge interleave - i.e. whatever the actual root device is
must be upstream of the host bridges themselves.

~Gregory
