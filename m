Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E3D1A9B58
	for <linux-cxl@vger.kernel.org>; Tue, 13 May 2025 05:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747112677; cv=none; b=DAy/Gx65p8YOqga0dW9x/V3oTNKnaXsczDpuWEl0VwX/Cu28werd9d+ORTt8tXWAanoUfr1I8rx0zpUO79LPlQVCvA3iaUb4pTmMg/Du/u+f/88Ic1kMs3z8uIuR/uNvBExHavH67PIslQmnBZQu3abibC60OfOTRwRVYJwzKRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747112677; c=relaxed/simple;
	bh=sTj3/GUHJMR5nx2l+/+vBXszZDOxoxcw6r9Mhk3ldxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8qKpW8unx0H6zHcqk5o3m6Vfje8T1g9j8azQMvP51d7ZH+w8KdzBt3d1T0tNHirNo6TZskrc8CTW6vpWuRVNXI6AMx1ls+qys8TBb7q2h/22ivblUcJQEZ9PNseuLlWScIP1vHe6PcV5O1lQp0M8pkuyS7nkR5Mo6mOK1hxEJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=KkBhbai8; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="KkBhbai8"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6f0cfbe2042so67217166d6.1
        for <linux-cxl@vger.kernel.org>; Mon, 12 May 2025 22:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747112673; x=1747717473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FB0pl0SAwX4FmaNv+NJJe3JVIcfhvdCHGf2CuyYZgnE=;
        b=KkBhbai8r/VOqTc1QV8/TfyI/dZUDEgb6KMj1jNLeh6QVexmTAuuWSvrOJg1JGtNi4
         al/EZ4K3RJ7ZI6e2CK0UQXW7L1xfUy01RMyvyiqRkpxWKutFv7hbHXhbdbaYLZ6S2x6R
         jTlctNHGWHNtByGQInJNA1d1DgA5P3JWhsPzCHB+6108T9NfS7EeXXPY5vPM03Ns/nuz
         CtIa/2heA8FEJQJP1/gyvr1xncoAN2oeC6/XeaKsbe5bx+CZwDyHNoqZ1AR2+9D07BqA
         +cQEb6oBm/wMn6TzoMoPeqb4WppuK1gxpwXxkurdTiuZRpjI1Sc6q5Zp7WJDe8cJAeES
         x/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747112673; x=1747717473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FB0pl0SAwX4FmaNv+NJJe3JVIcfhvdCHGf2CuyYZgnE=;
        b=kj1MJLJBWfyUF7fubcwBVvavRiEx3/G4dKVBQHNXVUF9iIkeTK+KE/GsPd1YHEOfTT
         Ex/yLMtNTzF8nwFS71VEwaKSVsjQk1WXsQ8yPBwe89SwDnI4+Ju7FvyaAZLsTuq5osLN
         DYIm7y7oK8t5C4uIHkhb+Iu2hRABg28PMxtB1MGF58qhTwtRhybEBcrGTvQtUxjBA5HA
         0K9vb4Dwx6kxUKxhrXBYFrao1jc/DRDLynL5C4Ki3dMjKA7Z3G21gdAdRSAIjdbvm8q6
         lp1VDYYtilfJIsGNxqWRJro1vc4xw6pncM2PjBUZ8uGkwoSHdH1NJAfELbOJ/7kQHwPl
         W7SQ==
X-Gm-Message-State: AOJu0Yy7lkfhUv71LhXaylZ4UnIX8QcgTbYFLTYES3sZdoBHGA+9JvD4
	Lhr8iemV5dAUXhE/Ju+ulBAjj9Q95IJPXY6xYDLnYy9xzHHqSIHRnkfVXJF6jII=
X-Gm-Gg: ASbGncvpGb5Lz495mS+0Mw8EJq8f9nPcbtO5PLboc5c1pySJ6jHWILATyV3KtCPLd5e
	Mmj4bUAbAPKeA+u/JEP9jg4Iex4c2l2ZVQfVHwjW9zZfrN4m9uM4/nafnjCV3FLptc5DvDPqNwW
	DqEMO/8S4RZap97WKcm73x9pF/du7weu0qbt68zrM/lIQs0BRhaGJn3ic6UtQ57VhRA50Peh6bZ
	Xa/nEJvbAZcE6SdP5KMJ5X6Dz3IoCGuOsIAnKFZ6nxfcf9BpvyffLS7mDat1kPDEd5TklnvHsmi
	BSFPZKFHX/Flt/AVmhtrJ1IZFfludoGslYnduLL5hzBJ2pUtCQuORzhNK6LSMRRXJZgNrqx4HLQ
	/Q+q/RJyDg5Zoz/n+gyAHUiUcKU6POZ4=
X-Google-Smtp-Source: AGHT+IEfwh4ZsgppOJ1SNqsoHlkHZbwtm1fv0jgoW2KfLoS9ftn48L5RCoMgPd6bcA4YjLZD6TUuqQ==
X-Received: by 2002:a05:6214:ca8:b0:6ea:eeb6:c82b with SMTP id 6a1803df08f44-6f85b549f3cmr34640326d6.2.1747112672802;
        Mon, 12 May 2025 22:04:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e3a0c715sm62988936d6.55.2025.05.12.22.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 22:04:32 -0700 (PDT)
Date: Tue, 13 May 2025 01:04:30 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, ira.weiny@intel.com, rrichter@amd.com,
	ming.li@zohomail.com
Subject: Re: [PATCH v2 02/10] cxl: Saperate out CXL dport->id vs actual dport
 hardware id
Message-ID: <aCLS3rQxkjxiDLDx@gourry-fedora-PF4VCD3F>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-3-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507004310.3536991-3-dave.jiang@intel.com>

On Tue, May 06, 2025 at 05:43:02PM -0700, Dave Jiang wrote:
> In preparation to allow dport to be allocated without being active, make
> dport->id to be Linux id that enumerates the dport objects per port.
> Keep the hardware id under dport->port_num to maintain compatibility and
> introduce a dport->id as the enumeration id.
>

This is more for the sake of clarity/documentation than anything else.

dport->port_num is the `hardware id` - i.e. what we'd find in an ACPI
table or something.  This number may not necessarily be unique

dport->port_id is now a Linux ID that is unique to the device.

For example, on my existing test system, i have this

[/sys/bus/cxl/devices]# ls port1/dport*
dport0  dport113  dport2 
[/sys/bus/cxl/devices]# ls port2/dport*
dport113  dport2
[/sys/bus/cxl/devices]# ls port3/dport*
dport0

I should now expect the following:

[/sys/bus/cxl/devices]# ls port1/dport*
dport0  dport1  dport2 
[/sys/bus/cxl/devices]# ls port2/dport*
dport0  dport1
[/sys/bus/cxl/devices]# ls port3/dport*
dport0


This should also apply to the root, whose dports were previously
dictated by the host bridge numbers defined in the CHBS/DSDT.

[/sys/bus/cxl/devices/root0]# ls
dport0  dport1  dport4  dport5

turns into

[/sys/bus/cxl/devices/root0]# ls
dport0  dport1  dport2  dport3


and my decoder0.0 target list ends up similarly changed

from
[/sys/bus/cxl/devices/root0/decoder0.0]# cat target_list
5,4

to

[/sys/bus/cxl/devices/root0/decoder0.0]# cat target_list
3,2

> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

If this is all correct, I like this.

Reviewed-by: Gregory Price <gourry@gourry.net>

~Gregory
