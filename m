Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D285214900B
	for <linux-cxl@vger.kernel.org>; Wed, 14 May 2025 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747239166; cv=none; b=Ir1SIckDnlVdXzHRLPXsGfZH0bi3j/w9V0eKCQHHPLicfaW1b08LodQgVq5gFn7FOrMOUI20bq8BogG19GwVuSCgKxSpXBaTsAbMR3lqj+C0khvm+Ld3xPMD8kGfFKSExKBZS3EnGZx3vdgnAAa2/SyfbkWJ4t1XJkmFuVdig9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747239166; c=relaxed/simple;
	bh=KPlOa8DwzLePVhUa7lgmgl63AmlmoGCrjN2ssDexlBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLVNLpn6v3aW/txZWeni/5z0S1KeD28jSHZJiabzeuXPoAcggXbdanwtRNOr88npmCa229AysilXSiWVfOIowNjiz+TeU+2Ff16IUQUdBby0TTPb/XywLhTIplxIv4fKJLL5EjsuI2dG6GqRgAVQJRrJHRgxqs8xf/xWq1Rzks0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=C8nZ3l8i; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="C8nZ3l8i"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6f6e6ec07f0so184086d6.3
        for <linux-cxl@vger.kernel.org>; Wed, 14 May 2025 09:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747239162; x=1747843962; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/NfVOtNoC+F+FoJW7SpLAOJzU2EBV77cQf+rBK9/IU=;
        b=C8nZ3l8i3FD9xFB8bgp3sC6fBflEenIXHgLEGRztBYUZFlApFsean63X1meBBhupOe
         r2qNXMx6KLDvuJ6Kfcu9QmdM2etPaBCWuXoo98P1R9c2FRMUU5dmPUsyeBUQztFU0S+j
         CPe3F9BHd2rxdMDVD1pmcZ34qQz3+FLDy1GiwV5oobaFnz8REeInT0M1o6i86JVjtP0o
         LLhEp4n+KcUKRIcAY/SgzZSwHS5u27++KDVhkvEWLwS1akeoBir9mMKRtD+JERZr07Wg
         2kSjFDQXpEaNE1vB/hl3tUj6JuQBifC29fRHgW3RP/n8jBgoK+hB6VwdysQD76P8k5Ci
         L3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747239162; x=1747843962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/NfVOtNoC+F+FoJW7SpLAOJzU2EBV77cQf+rBK9/IU=;
        b=u8ldJaLo5AGhjwmi+3LMCmc6P861Lvpr+We65QxWVNLq3xYChe0E1VZ9Ke0ugzyKh8
         6za9Jky/+TxdcDA6lzwvDASdKBGLAf/YyGsMumO4zNT5PmG9xFsJETItDS0NXzU+HHys
         w7PQJvXJwkwRhLQh4/L0oDhc+gykRXQ7aCgLlDFPWKTH1KJ3T52VrUjd4gUScB5eDu9T
         ys/vVmw19gLSx9p3292eByE3N2N/zSFuH+Yv8xKLaFVKeFxEg8VWqhbQj08VWKvZAOHz
         Q0oCbineVR43ullCN12zCDdHxDVTMjZD5Y2wmHjfc2/wnsjwIPbvoq5JTTnOvLDxF97a
         PZzA==
X-Gm-Message-State: AOJu0YzJRNuTMM7DnLgkjb2oNTrbavXLoVtHwlMPP3bzCzXGh9CDWxrG
	co87/bSOg1BTZ/dPnDBpTYNTYpqv6qNEmIXbcBPaHtz7g1i5Aw4TzV+m8fqfzSA=
X-Gm-Gg: ASbGnctSI0iYA4Dw9jk8jqdYLd6AzaaBdZvl1+kpdJWferkQTnrAfq2A0/WR1oDkAN2
	ZU/9r335PUEqRcOMzutnjJ0p85qRISHU82h0i4Qnuq7i6EJVkQ1EqAoocGii9k/cxnRjaO1WgDN
	OZ4XCiHHheZoZrKzLbMZNRKLR7+taoFRvFDzW5AkwJKdzaWVZV9lClW1CuGubf/cMsgvJ1iJzGL
	jTmGZ9Vu8wzbPWyYHE7x+YhSmm3V7Piirvnz/uvSeZvcWiqtuEXtdtwvA6k7HQlZ4UgWoLHAAcA
	QpjdtpuFu5ygemD6RO0eZI3AdHoKRJ4rlMEv4AK78Ryx9QboV1L7V+5xPfs+x4OFAEH/vT1Xo5S
	lJmbeRX+LPSxNIRCCofj6w6YhnfXZaec=
X-Google-Smtp-Source: AGHT+IGRGVzIXS3ZI83NeexKaDMbT2jbdCpOoQvCr4RkXgEBow5f/Tx0nZuDIb07/HcbV6S6/mw4fQ==
X-Received: by 2002:ad4:5def:0:b0:6e6:6089:4978 with SMTP id 6a1803df08f44-6f896e35fc7mr54362896d6.24.1747239162484;
        Wed, 14 May 2025 09:12:42 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f6e3a4731csm82302046d6.78.2025.05.14.09.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 09:12:42 -0700 (PDT)
Date: Wed, 14 May 2025 12:12:40 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH 1/4] cxl: docs/platform/cdat reference documentation
Message-ID: <aCTA-C9StbfHjCMn@gourry-fedora-PF4VCD3F>
References: <20250514003133.584401-1-dave.jiang@intel.com>
 <20250514003133.584401-2-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514003133.584401-2-dave.jiang@intel.com>

On Tue, May 13, 2025 at 05:31:30PM -0700, Dave Jiang wrote:
> Add documentation for CDAT sub-tables for CXL usages.
> 

Mostly wording nits, but i recommend putting allt he subtables in
cdat.rst directly and adding a terms list at the top so you can
reference them cleanly on the same page without redefining them
everywhere.  See below.

> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  Documentation/driver-api/cxl/index.rst        |  1 +
>  .../driver-api/cxl/platform/cdat.rst          | 24 ++++++++++
>  .../driver-api/cxl/platform/cdat/dslbis.rst   | 33 ++++++++++++++
>  .../driver-api/cxl/platform/cdat/dsmas.rst    | 23 ++++++++++
>  .../driver-api/cxl/platform/cdat/sslbis.rst   | 45 +++++++++++++++++++
>  5 files changed, 126 insertions(+)
>  create mode 100644 Documentation/driver-api/cxl/platform/cdat.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/cdat/dslbis.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/cdat/dsmas.rst
>  create mode 100644 Documentation/driver-api/cxl/platform/cdat/sslbis.rst
> 
> diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> index 366faf851fc7..9e1414ad3357 100644
> --- a/Documentation/driver-api/cxl/index.rst
> +++ b/Documentation/driver-api/cxl/index.rst
> @@ -27,6 +27,7 @@ that have impacts on each other.  The docs here break up configurations steps.
>  
>     platform/bios-and-efi
>     platform/acpi
> +   platform/cdat
>     platform/example-configs
>  
>  .. toctree::
> diff --git a/Documentation/driver-api/cxl/platform/cdat.rst b/Documentation/driver-api/cxl/platform/cdat.rst
> new file mode 100644
> index 000000000000..3e0ce7099db3
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/cdat.rst
> @@ -0,0 +1,24 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===========
> +CDAT Tables
> +===========

"Coherent Device Attribute Table Tables" :]

I would name this 

======================================
Coherent Device Attribute Table (CDAT)
======================================

> +
> +The Coherent Device Attribute Table (CDAT) is created to provide a standard way to
> +expose the properties of a device such as an CXL accelerator or switch. The table
> +formatting is similar to ACPI tables. The tables are created to provide performance
> +calculation of a hot-plugged device where ACPI HMAT+SRAT tables are not able to
> +enumerate the performance by the BIOS ahead of time.

I may suggest something like...

The CDAT provides functional and performance attributes of devices such
as CXL accelerators, switches, or endpoints.  The table formatting is
similar to ACPI tables. CDAT data may be parsed by BIOS at boot or may
be enumerated at runtime (after device hotplug, for example).

> +
> +The following CDAT tables contain *static* configuration and performance data about CXL devices.
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   cdat/dsmas.rst
> +   cdat/dslbis.rst
> +   cdat/sslbis.rst
> +
> +The Linux CXL driver uses these tables in addition to attributes of the CXL links and
                                                      ^^^^^^^^^^^^^
						      provided by what?
> +Generic Target performance data provided by HMAT+SRAT to create the whole path performance
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   The is provided by SRAT right?
> +for a CXL device.

Maybe simplified to:

The CXL driver uses a combination of CDAT, HMAT, SRAT and other data to
generate "whole path performance" data for a CXL device.

> diff --git a/Documentation/driver-api/cxl/platform/cdat/dslbis.rst b/Documentation/driver-api/cxl/platform/cdat/dslbis.rst
> new file mode 100644
> index 000000000000..91ae426b2e8b
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/cdat/dslbis.rst
> @@ -0,0 +1,33 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================================================================
> +DSLBIS - Device Scoped Latency and Bandwidth Information Structure
> +==================================================================
> +
> +The Device Scoped Latency and Bandwidth Information Structure contains latency
> +and bandwidth information based on DSMADHandle matching.
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
			     What does a DSMADHandle represent?
> +
> +This table is used by Linux in conjunction with Device scoped Memory Affinity
> +Structure to determine the performance attributes of a CXL device.

swap the order of the last two paragraphs.  Add (DSMAS) after "Device
Scoped Memory Affinity Structure", introduce what a DSMADHandle is and
what it represents before you reference it.

> +
> +Example ::
> +
> +   Structure Type : 01 [DSLBIS]
> +         Reserved : 00
> +           Length : 18                     <- 24d, size of structure
> +           Handle : 0001                   <- DSMAS handle
> +            Flags : 00                     <- Matches flag field for HMAT SLLBIS
> +        Data Type : 00                     <- Latency
> + Entry Basee Unit : 0000000000001000       <- Entry Base Unit field in HMAT SSLBIS
> +            Entry : 010000000000           <- First byte used here, CXL LTC
> +         Reserved : 0000
> +
> +   Structure Type : 01 [DSLBIS]
> +         Reserved : 00
> +           Length : 18                     <- 24d, size of structure
> +           Handle : 0001                   <- DSMAS handle
> +            Flags : 00                     <- Matches flag field for HMAT SLLBIS
> +        Data Type : 03                     <- Bandwidth
> + Entry Basee Unit : 0000000000001000       <- Entry Base Unit field in HMAT SSLBIS
> +            Entry : 020000000000           <- First byte used here, CXL BW
> +         Reserved : 0000
> diff --git a/Documentation/driver-api/cxl/platform/cdat/dsmas.rst b/Documentation/driver-api/cxl/platform/cdat/dsmas.rst
> new file mode 100644
> index 000000000000..8c32ddb3381c
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/cdat/dsmas.rst
> @@ -0,0 +1,23 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============================================
> +DSMAS - Device Scoped Memory Affinity Structure
> +===============================================

Device Scoped Memory Affinity Structure (DSMAS)

> +
> +The Device Scoped Memory Affinity Structure contains information such as
       ^^^^^^        DSMAS               ^^^^^
       Since you define it in the header, you can use the abbreviation
 
> +DSMADHandle, the DPA Base, and DPA Length.
> +

It's probably better to put all these subtables in a single document
(cdat.rst) and add a terms list at the top (such as DSMADHandle)

> +This table is used by Linux in conjunction with the Device Scoped Latency and
> +Bandwidth Information Structure (DSLBIS) to determine the performance
> +attributes of the CXL device itself.
> +
> +Example ::
> +
> + Structure Type : 00 [DSMAS]
> +       Reserved : 00
> +         Length : 0018              <- 24d, size of structure
> +    DSMADHandle : 01
> +          Flags : 00
> +       Reserved : 0000
> +       DPA Base : 0000000040000000  <- 1GiB base
> +     DPA Length : 0000000080000000  <- 2GiB size
> diff --git a/Documentation/driver-api/cxl/platform/cdat/sslbis.rst b/Documentation/driver-api/cxl/platform/cdat/sslbis.rst
> new file mode 100644
> index 000000000000..e299575493fa
> --- /dev/null
> +++ b/Documentation/driver-api/cxl/platform/cdat/sslbis.rst
> @@ -0,0 +1,45 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================================================================
> +SSLBIS - Switch Scoped Latency and Bandwidth Information Structure
> +==================================================================

Switch Scoped Latency and Bandwidth Information Structure (SSLBIS)

> +
> +The Switch Scoped Latency Bandwidth Information Structure contains information
       ^^^^^^^^^^^^^^^^ SSLBIS ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +about the latency and bandwidth of a switch.
> +
> +The table is used by Linux to compute the performance coordinates of a CXL path
> +from the device to the root port where a switch is part of the path.
> +
> +Example ::
> +
> +  Structure Type : 05 [SSLBIS]
> +        Reserved : 00
> +          Length : 20                           <- 32d, length of record, including SSLB entries
> +       Data Type : 00                           <- Latency
> +        Reserved : 000000
> + Entry Base Unit : 00000000000000001000         <- Matches Entry Base Unit in HMAT SSLBIS
> +
> +                                                <- SSLB Entry 0
> +       Port X ID : 0100                         <- First port, 0100h represents an upstream port
> +       Port Y ID : 0000                         <- Second port, downstream port 0
> +         Latency : 0100                         <- Port latency
> +        Reserved : 0000
> +                                                <- SSLB Entry 1
> +       Port X ID : 0100
> +       Port Y ID : 0001
> +         Latency : 0100
> +        Reserved : 0000
> +
> +
> +  Structure Type : 05 [SSLBIS]
> +        Reserved : 00
> +          Length : 18                           <- 24d, length of record, including SSLB entry
> +       Data Type : 03                           <- Bandwidth
> +        Reserved : 000000
> + Entry Base Unit : 00000000000000001000         <- Matches Entry Base Unit in HMAT SSLBIS
> +
> +                                                <- SSLB Entry 0
> +       Port X ID : 0100                         <- First port, 0100h represents an upstream port
> +       Port Y ID : FFFF                         <- Second port, FFFFh indicates any port
> +       Bandwidth : 1200                         <- Port bandwidth
> +        Reserved : 0000
> -- 
> 2.49.0
> 
