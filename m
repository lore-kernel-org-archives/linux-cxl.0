Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2771A23AD
	for <linux-cxl@vger.kernel.org>; Tue, 13 May 2025 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747151020; cv=none; b=rxFioAx8wYnw5uz2/sJfmud8s4AYp9c2TzBUjtUqdwqcG3l2UtEGOSLk/ZDZDoyKdleE8XI8VRhnq0GiKRihDyCd+1Hk1qG0t/GfQ7/myFvnSV2cUuXHYgZPANdNZ+PHPli4rUpsZAGmmJFxtCqtoNeXaUnxxDXR9ny+xFMkEIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747151020; c=relaxed/simple;
	bh=2aPvcg+RHBNECv+K/jLOa6TKVwcbsxEPbiriuZ/g1bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8c2ZVTnoyaxyrYI3DsC3UeMX+iVM/vqAoERHbJUdyY/9AWdy5vsqcDY9hYFhMXIoEBwOJK+l5ti1ZCddFZM8N018xZ32Cv78d4Rj9PzbPlpqKIvbpN6Kwid/5kqOOs1Oly4isHedBOxKqQkd87V7o3PaXhxu036TeqSflLDLfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=qNdHMYmz; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="qNdHMYmz"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c560c55bc1so722552085a.1
        for <linux-cxl@vger.kernel.org>; Tue, 13 May 2025 08:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747151017; x=1747755817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rrlKc5Bez2eF8DcEwGZSOMtHxXJqJ6oPJFYRy8hkRmQ=;
        b=qNdHMYmziGYBBqIqc8AAXioY4cME7t+1629gdg3WSXZRpE5E0Vvj2duJOJWCM9k2hl
         f8jKYAaVd0f4KwB340UWEAKSILl2n6ck/hd80EHUhPsR4W+ccSBCcq4VaUnbjif62Xjz
         GYMT9VrA6DRDQ67NCeGapuJ3U9iahVPc/HpBGhqyMBCXTQpOwaxMsQqvUP2Smyd9sxQJ
         yDoHJrqQjrloshMEwhQv0ZWb4z7QDkXI0NGuXpa3dRzYxL3Ddjqbv97DMvkbdPAUWOIg
         Oh5zW434uzsWiq+NLn/PdLS3ZcbB7kwE75uKFOYV1perQDK/0iXGb6HDjhu4fjtyXnpk
         19aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747151017; x=1747755817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrlKc5Bez2eF8DcEwGZSOMtHxXJqJ6oPJFYRy8hkRmQ=;
        b=Dp2gCrk8OxTbDFT2XgZSqSKFWU+Ny1bw77cRSrNwDRJD+hF24o/HNPwRfbPCCaIaey
         rIRNaBfAGxpTE24i/JVEwl9Epr9yC2GkrefKbCUsBh3z+QQlGblQ9BFg0kj9b2C9mqLk
         Tsay61CEhbGalhqaQyRYi5yMJk5wVfhyz6pxjXw90T83XvzJAZHA7xULI0BDVx9P1HI5
         3x8Sbc22YDbJJhVbRataNqSGbuLvQPSgohiNr/eA9sAE6Rzei7xnyI0Q29S1ElnYceh0
         Cs9FaoQe19EVZr12M69awHHGDklW/nOn3gr28GK3KBUpbsxr0YCMSWfMPZXGhlr4RHPd
         FmTQ==
X-Gm-Message-State: AOJu0YwH/EUTbVvc+tXxqLcgZgs5NrHVAv6irX1GSP3gssaFqyvVrN9k
	1ql39ShSPPpmxpY33Lga9/cxLczmT2XpLS38Z60fyQ56VwUPG7o7YS3pRgyaDL8=
X-Gm-Gg: ASbGncu7ac+tp+A/6lqQn09i+16GljSmqNL/WD6Pnql189lnVABshujtGl++sBxOIRG
	Y1nnn+8+IT8bHeTZxILCHsy1tRC3WcFsFLu6BxUS58SoNfHdkEME6HFOc3HDO4RJPIk300X9sxh
	dBVA79YOx/YG2/YGmlKYURrj2lOfXk0wXRykkZA4OTcjUF5N2KbcrMgIpO96jr2Q2YHpDsdPFXP
	GVRvabck8uIjf2i2a6owtwYDT+81KctTWaKLNjgSedbCM697p01S2kl+gNRRZfrQ+NfH8LdJK7W
	X4PRRh50Sleo7/rcaZKJG/GVmw2GITLTLRIk2Qo0APx1NVf8N5SRHUH2mISNz3/x61XNc+OStGs
	B28qU9JEA9Ftk66RFcW/dHT8dAhGD8bw=
X-Google-Smtp-Source: AGHT+IEJUeMT5BCQgKDvtWso/ZUf8LEDqTP/7pcF/WcYvv58p+rd3WWi2o2PUSnfWmEoHv/+q0itYQ==
X-Received: by 2002:ad4:5aa5:0:b0:6f5:40d5:e51 with SMTP id 6a1803df08f44-6f6e47c2f7emr269949126d6.11.1747151017252;
        Tue, 13 May 2025 08:43:37 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e3a0c567sm67974806d6.62.2025.05.13.08.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 08:43:36 -0700 (PDT)
Date: Tue, 13 May 2025 11:43:34 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, ira.weiny@intel.com, rrichter@amd.com,
	ming.li@zohomail.com
Subject: Re: [PATCH v2 05/10] cxl: Defer hardware dport->port_id assignment
 and registers probing
Message-ID: <aCNopruv5rUV2PBr@gourry-fedora-PF4VCD3F>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-6-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507004310.3536991-6-dave.jiang@intel.com>

On Tue, May 06, 2025 at 05:43:05PM -0700, Dave Jiang wrote:
> Current implementation only enumerates the dports during the port probe.
> Without an endpoint connected, the dport may not be active during port
> probe. This scheme may prevent a valid hardware dport id to be retrieved
> and MMIO registers to be read when an endpoint is hot-plugged. Move the hw
> dport id assignment and the register probing to behind memdev probe so the
> endpoint is guaranteed to be connected.
> 
> The detection of duplicate dport for add_dport() is removed. The port_id
> is not read from the hw at this point any longer. The port->id will always
> be unique since it's retrieved from an ida. The dup detection thus become
> irrelevant.
> 
> The decoders must also be updated since previously it's all done when all
> the dports are setup and now every time a dport is setup per endpoint, the
> switch target listing need to be updated with new dport.
> 

I'm finding the changes a little difficult to follow, can you lay out
the expected order of operations before and after?

Specifically there's two new guard() calls, can you explain under what
conditions those can be contended?

~Gregory

> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 70173d23139c..04e18a102d26 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
... snip ...
> +static int update_switch_decoder(struct device *dev, void *data)
> +{
> +	struct cxl_dport *dport = data;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_decoder *cxld;
> +	int i;
> +
> +	if (!is_switch_decoder(dev))
> +		return 0;
> +
> +	cxlsd = to_cxl_switch_decoder(dev);
> +	cxld = &cxlsd->cxld;
> +	guard(rwsem_write)(&cxl_region_rwsem);
> +	for (i = 0; i < cxld->interleave_ways; i++) {
> +		if (cxlsd->target_map[i] == dport->port_num) {
> +			cxlsd->target[i] = dport;
> +			return 0;
> +		}
> +	}
... snip ...
> @@ -1695,6 +1798,19 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  				"found already registered port %s:%s\n",
>  				dev_name(&port->dev),
>  				dev_name(port->uport_dev));
> +
> +			/*
> +			 * Attempt to do single pass dport setup by checking here
> +			 * instead of doing it during port creation. Otherwise
> +			 * it still needs to check here for dports that are
> +			 * being probed with a port already created.
> +			 */
> +			scoped_guard(device, &port->dev) {
> +				rc = cxl_switch_port_dport_setup(port, dport_dev);
> +				if (rc)
> +					return rc;
> +			}
> +
... snip ...
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index a35fc5552845..4d840a6ef802 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
... snip ...
>  	/* Cache the data early to ensure is_visible() works */
> @@ -69,24 +68,7 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  	if (rc < 0)
>  		return rc;
>  
... snip ...
> -	return -ENXIO;
> +	return 0;
>  }

	return devm_cxl_port_enumerate_dports(port);


~Gregory
