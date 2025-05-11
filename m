Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE6C1A5B85;
	Sun, 11 May 2025 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746954850; cv=none; b=Lt8a3ze9xfRsz3beYQOmHzdOWzYCAOH/28bil/ZjqYTO0nAboGNthm3+/FjdfGifGB2UF8+AjRBMhuxsadEsHdt9vUfZWpFSS24/HXuAPs6Uyq8C3fm4CwwAopaCrMlzOBGpYbz2zEefDxzxiOW2AQcEK55CgMC/dxCr6dEAjXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746954850; c=relaxed/simple;
	bh=sDJTFSCGAp/2tDi3rAalcSx0WZq9g7iBTB+DWORcGaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnxIrCzUltlKYfENEZbzF6NW4EJo1TvHanJsD21JpOhIVvmbRGRqH9h8mqxcpxn2AbllQEgkUsg1nMHNKqmaBgbya7Sechg8vZkSs/No4xouMhZwdMkoqpTCpDZAs+RgRTOMsYRAoC8vs7eys3Zgc+zOeebFeU7iXtfdKPPbIZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sbbu8nFp; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sbbu8nFp"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b200047a6a5so2524588a12.0;
        Sun, 11 May 2025 02:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746954847; x=1747559647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I5rtl0LYTO7WHTgU+H+HRcpLoLAy9BYGexKEPYSp3/M=;
        b=Sbbu8nFpGnv3k8Uhnwq8S6JAGHzgfsUXlSybwhKduralgp6UrQuCbWqJWpjOsJQMX4
         RZOpq+r43pA4YQeAS92d7EI0RIGkaKn9tkAKmYpSKaSyP0nW9JYurHMHy8B77G7vqiJX
         ySBkuP0jf6frsq7o7ojh2qWZI0ISTgOD+XWALbEdSyBizZqq41w7NdIrImDl506XLCJF
         8YkHc3uUCuUTLRSK6X/LShUM3NanXA5+PRF9i+p+nOFxmopsXN75v9T2BIXWFDfd8esZ
         C5JYD6XykB//OpiDdiDPQx64uwdwrhWF+MjYX4Tqcy3LnRl07PMp96KITUZAoda4D2q4
         ARyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746954847; x=1747559647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5rtl0LYTO7WHTgU+H+HRcpLoLAy9BYGexKEPYSp3/M=;
        b=kT6hGYwBScUyRNPMibSWwPLFqfVLdq8b/c7PU4k8PTwHhgFCK9ATbykOc5PhE4RSMw
         bpp/6hdV2A9VfTMMbeViEB0KjWkeZueR2uJnFgGH+xTR1n4L8yUoRLevYjIwB6pvbLtr
         4fopm3uIN0Q4rgJ9akT67lB145d9E8lSYKbvWIS8gwEP7f7G47KCXgBojpjfGo4/Zz78
         DwwJfTVEvWTQiMv0yUIiBmadSlwX4jRWXypYeXxr7fhSqE+nIE5d7tyZ2NvXM0/NiYtB
         8Cj+ulSJvwTIC+yIb3QdkKY58E0zA7Cgq9YI/tYiGXq00KtuxpGtbDzXvP6UYf1BumTw
         oVbg==
X-Forwarded-Encrypted: i=1; AJvYcCUaj62wIzU7MrcVpSg7CzgOTbyK0mWDMkWeyOjO0nXM6dRs2elzEqZQADjS1rpaQQDnjsncCaafh++1yzpd@vger.kernel.org, AJvYcCXsxqSVg5LFkvtO+I3xphdv/M9io872VVz6zjAwwjSxVZYMcGa+WgSgezMnwMZbM8KF8x5WHDuQrQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2mFvkgkmOeTtusUY11Oj3IWDhpM0gek21MY10REWfsw+TH5i2
	f17NvaNrXNamOf6MAeEGSPIJxuqbnGFO8HLnQzwhdz7lRKiXRi2V
X-Gm-Gg: ASbGncsuFRV8dxRZ5cqnsd6clShK97uzP1muaanRAr26WbvKtdI0v4U66D8O49zwN7a
	HEwJv/1xy9lONg/mBSmfeZT7VJ7txh5swWy07yFzjuhdmWsxx3u73rTg1De+/XsYeyQ5qK3mObY
	yPfN0Bg9VVaN76yKzgds9V17ho3H7XP7fJ3oCs5IAmagjnqnwO36UyDpcYU5LsAAzs35kWADm53
	vZLe5lgdGCDYzE05/eqXbBa6cpySQoV04rDVeOZoKyrXzUi4iopA0IL7cgSToktha8OEwWzfgDv
	RueWyhUkoU1zNN9pOZ2GcOsGF5ud4c3hNnMRloMSQdbRFZjUeS0=
X-Google-Smtp-Source: AGHT+IHAlJqoZGnFfodyH1cSLv1yg15eEQPCWRShdg2J3jHViLfW78RKAZaeHsVDY6yYEzdbCj8j/A==
X-Received: by 2002:a17:902:c946:b0:21f:2e:4e4e with SMTP id d9443c01a7336-22fc92f41d6mr146920935ad.5.1746954846373;
        Sun, 11 May 2025 02:14:06 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc7742ce2sm43817055ad.80.2025.05.11.02.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 02:14:05 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 21AA14201B85; Sun, 11 May 2025 16:14:03 +0700 (WIB)
Date: Sun, 11 May 2025 16:14:02 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com, corbet@lwn.net
Subject: Re: [RFC PATCH v2 18/18] cxl: docs - add self-referencing cross-links
Message-ID: <aCBqWib0Cl2OdQgR@archie.me>
References: <20250430181048.1197475-1-gourry@gourry.net>
 <20250430181048.1197475-19-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L/cc5o7PhJNIWkaT"
Content-Disposition: inline
In-Reply-To: <20250430181048.1197475-19-gourry@gourry.net>


--L/cc5o7PhJNIWkaT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 02:10:48PM -0400, Gregory Price wrote:
> diff --git a/Documentation/driver-api/cxl/devices/device-types.rst b/Docu=
mentation/driver-api/cxl/devices/device-types.rst
> index dfe8d4711987..f33a40d2284d 100644
> --- a/Documentation/driver-api/cxl/devices/device-types.rst
> +++ b/Documentation/driver-api/cxl/devices/device-types.rst
> @@ -115,7 +115,7 @@ A Multi-Headed Single-Logical Device (MHSLD) exposes =
a single logical
>  device to multiple heads which may be connected to one or more discrete
>  hosts.  An example of this would be a simple memory-pool which may be
>  statically configured (prior to boot) to expose portions of its memory
> -to Linux via the CEDT ACPI table.
> +to Linux via Documentation/driver-api/cxl/platform/acpi/cedt.rst
> =20
>  MHMLD
>  ~~~~~
> diff --git a/Documentation/driver-api/cxl/linux/access-coordinates.rst b/=
Documentation/driver-api/cxl/linux/access-coordinates.rst
> index b07950ea30c9..24db5b41716a 100644
> --- a/Documentation/driver-api/cxl/linux/access-coordinates.rst
> +++ b/Documentation/driver-api/cxl/linux/access-coordinates.rst
> @@ -24,7 +24,8 @@ asymmetry in properties does not happen and all paths t=
o EPs are equal.
> =20
>  There can be multiple switches under an RP. There can be multiple RPs un=
der
>  a CXL Host Bridge (HB). There can be multiple HBs under a CXL Fixed Memo=
ry
> -Window Structure (CFMWS).
> +Window Structure (CFMWS) in the
> +Documentation/driver-api/cxl/platform/acpi/acpi/cedt.rst.
> =20
>  An example hierarchy:
> =20
> @@ -83,8 +84,9 @@ also the index for the resulting xarray.
> =20
>  The next step is to take the min() of the per host bridge bandwidth and =
the
>  bandwidth from the Generic Port (GP). The bandwidths for the GP is retri=
eved
> -via ACPI tables SRAT/HMAT. The min bandwidth are aggregated under the sa=
me
> -ACPI0017 device to form a new xarray.
> +via ACPI tables Documentation/driver-api/cxl/platform/acpi/srat.rst and
> +Documentation/driver-api/cxl/platform/acpi/hmat.rst. The min bandwidth a=
re
> +aggregated under the same ACPI0017 device to form a new xarray.
> =20
>  Finally, the cxl_region_update_bandwidth() is called and the aggregated
>  bandwidth from all the members of the last xarray is updated for the
> diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Document=
ation/driver-api/cxl/linux/cxl-driver.rst
> index 1a354ea1cda4..b4cb1910adde 100644
> --- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
> +++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
> @@ -77,11 +77,11 @@ Root Object` Device Class is found.
> =20
>  The Root contains links to:
> =20
> -* `Host Bridge Ports` defined by ACPI CEDT CHBS.
> +* `Host Bridge Ports` defined by CHBS in Documentation/driver-api/cxl/pl=
atform/acpi/cedt.rst.
> =20
>  * `Downstream Ports` typically connected to `Host Bridge Ports`
> =20
> -* `Root Decoders` defined by ACPI CEDT CFMWS.
> +* `Root Decoders` defined by CFMWS in Documentation/driver-api/cxl/platf=
orm/acpi/cedt.rst.
> =20
>  ::
> =20
> @@ -150,9 +150,9 @@ An `endpoint` is a terminal port in the fabric.  This=
 is a `logical device`,
>  and may be one of many `logical devices` presented by a memory device. It
>  is still considered a type of `port` in the fabric.
> =20
> -An `endpoint` contains `endpoint decoders` available for use and the
> -*Coherent Device Attribute Table* (CDAT) used to describe the capabiliti=
es
> -of the device. ::
> +An `endpoint` contains `endpoint decoders` available for use and the CDA=
T in
> +Device's Documentation/driver-api/cxl/devices/uefi.rst used to describe =
the
> +capabilities of the device. ::
> =20
>    # ls /sys/bus/cxl/devices/endpoint5
>      CDAT        decoders_committed  modalias      uevent
> @@ -247,17 +247,18 @@ parameter.
>  Root Decoder
>  ~~~~~~~~~~~~
>  A `Root Decoder` is logical construct of the physical address and interl=
eave
> -configurations present in the ACPI CEDT CFMWS.  Linux presents this info=
rmation
> -as a decoder present in the `CXL Root`.  We consider this a `Root Decode=
r`,
> -though technically it exists on the boundary of the CXL specification and
> -platform-specific CXL root implementations.
> +configurations present in the CFMWS field of the
> +Documentation/driver-api/cxl/platform/acpi/cedt.rst.
> +Linux presents this information as a decoder present in the `CXL Root`. =
 We
> +consider this a `Root Decoder`, though technically it exists on the boun=
dary
> +of the CXL specification and platform-specific CXL root implementations.
> =20
>  Linux considers these logical decoders a type of `Routing Decoder`, and =
is the
>  first decoder in the CXL fabric to receive a memory access from the plat=
form's
>  memory controllers.
> =20
>  `Root Decoders` are created during :code:`cxl_acpi_probe`.  One root dec=
oder
> -is created per CFMWS entry in the ACPI CEDT.
> +is created per CFMWS entry in the Documentation/driver-api/cxl/platform/=
acpi/cedt.rst.
> =20
>  The :code:`target_list` parameter is filled by the CFMWS target fields. =
Targets
>  of a root decoder are `Host Bridges`, which means interleave done at the=
 root
> @@ -267,9 +268,11 @@ Only root decoders are capable of `Inter-Host-Bridge=
 Interleave`.
> =20
>  Such interleaves must be configured by the platform and described in the=
 ACPI
>  CEDT CFMWS, as the target CXL host bridge UIDs in the CFMWS must match t=
he CXL
> -host bridge UIDs in the ACPI CEDT CHBS and ACPI DSDT.
> +host bridge UIDs in the CHBS field of the
> +Documentation/driver-api/cxl/platform/acpi/cedt.rst and the UID field of=
 CXL
> +Host Bridges defined in the Documentation/driver-api/cxl/platform/acpi/d=
sdt.rst.
> =20
> -Interleave settings in a rootdecoder describe how to interleave accesses=
 among
> +Interleave settings in a root decoder describe how to interleave accesse=
s among
>  the *immediate downstream targets*, not the entire interleave set.
> =20
>  The memory range described in the root decoder is used to
> @@ -531,10 +534,11 @@ granularity configuration.
> =20
>  At Root
>  ~~~~~~~
> -Root decoder interleave is defined by the ACPI CEDT CFMWS.  The CEDT
> -may actually define multiple CFMWS configurations to describe the same
> -physical capacity - with the intent to allow users to decide at runtime
> -whether to online memory as interleaved or non-interleaved. ::
> +Root decoder interleave is defined by CFMWS field of the
> +Documentation/driver-api/cxl/platform/acpi/cedt.rst.  The CEDT may actua=
lly
> +define multiple CFMWS configurations to describe the same physical capac=
ity,
> +with the intent to allow users to decide at runtime whether to online me=
mory
> +as interleaved or non-interleaved. ::
> =20
>               Subtable Type : 01 [CXL Fixed Memory Window Structure]
>         Window base address : 0000000100000000
> diff --git a/Documentation/driver-api/cxl/linux/early-boot.rst b/Document=
ation/driver-api/cxl/linux/early-boot.rst
> index 275174d5b0bb..309cc6999c6b 100644
> --- a/Documentation/driver-api/cxl/linux/early-boot.rst
> +++ b/Documentation/driver-api/cxl/linux/early-boot.rst
> @@ -12,7 +12,8 @@ read EFI and ACPI information throughout this process t=
o configure logical
>  representations of the devices.
> =20
>  During Linux Early Boot stage (functions in the kernel that have the __i=
nit
> -decorator), the system takes the resources created by EFI/BIOS (ACPI tab=
les)
> +decorator), the system takes the resources created by EFI/BIOS
> +(Documentation/driver-api/cxl/platform/acpi.rst)
>  and turns them into resources that the kernel can consume.
> =20
> =20
> @@ -69,13 +70,15 @@ significant impact performance depending on the memor=
y capacity of the system.
>  NUMA Node Reservation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -Linux refers to the proximity domains (:code:`PXM`) defined in the SRAT =
to
> -create NUMA nodes in :code:`acpi_numa_init`. Typically, there is a 1:1 r=
elation
> -between :code:`PXM` and NUMA node IDs.
> +Linux refers to the proximity domains (:code:`PXM`) defined in the
> +Documentation/driver-api/cxl/platform/acpi/srat.rst to create NUMA nodes=
 in
> +:code:`acpi_numa_init`. Typically, there is a 1:1 relation between
> +:code:`PXM` and NUMA node IDs.
> =20
> -SRAT is the only ACPI defined way of defining Proximity Domains. Linux c=
hooses
> -to, at most, map those 1:1 with NUMA nodes. CEDT adds a description of S=
PA
> -ranges which Linux may wish to map to one or more NUMA nodes
> +The SRAT is the only ACPI defined way of defining Proximity Domains. Lin=
ux
> +chooses to, at most, map those 1:1 with NUMA nodes.
> +Documentation/driver-api/cxl/platform/acpi/cedt.rst
> +adds a description of SPA ranges which Linux may map to one or more NUMA=
 nodes
> =20
>  If there are CXL ranges in the CFMWS but not in SRAT, then a fake :code:=
`PXM`
>  is created (as of v6.15). In the future, Linux may reject CFMWS not desc=
ribed
> @@ -88,7 +91,7 @@ data for Linux to identify NUMA nodes their associated =
memory regions.
> =20
>  The relevant code exists in: :code:`linux/drivers/acpi/numa/srat.c`.
> =20
> -See the Example Platform Configurations section for more information.
> +See Documentation/driver-api/cxl/platform/example-configs.rst for more i=
nfo.
> =20
>  Memory Tiers Creation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> @@ -107,10 +110,13 @@ Tier membership can be inspected in ::
>    /sys/devices/virtual/memory_tiering/memory_tierN/nodelist
>    0-1
> =20
> -If nodes are grouped which have clear difference in performance, check t=
he HMAT
> -and CDAT information for the CXL nodes.  All nodes default to the DRAM t=
ier,
> -unless HMAT/CDAT information is reported to the memory_tier component via
> -`access_coordinates`.
> +If nodes are grouped which have clear difference in performance, check t=
he
> +Documentation/driver-api/cxl/platform/acpi/hmat.rst and CDAT
> +(Documentation/driver-api/cxl/devices/uefi.rst) information for the CXL =
nodes.
> +All nodes default to the DRAM tier, unless HMAT/CDAT information is repo=
rted
> +to the memory_tier component via `access_coordinates`.
> +
> +For more, see Documentation/driver-api/cxl/linux/access-coordinates.rst.
> =20
>  Contiguous Memory Allocation
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> diff --git a/Documentation/driver-api/cxl/platform/bios-and-efi.rst b/Doc=
umentation/driver-api/cxl/platform/bios-and-efi.rst
> index 552a83992bcc..cdbba6798079 100644
> --- a/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> +++ b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
> @@ -22,7 +22,7 @@ At a high level, this is what occurs during this phase =
of configuration.
> =20
>  Much of what this section is concerned with is ACPI Table production and
>  static memory map configuration. More detail on these tables can be found
> -under Platform Configuration -> ACPI Table Reference.
> +at Documentation/driver-api/cxl/platform/acpi.rst.
> =20
>  .. note::
>     Platform Vendors should read carefully, as this sections has recommen=
dations
> @@ -175,9 +175,10 @@ to implement driver support for your platform.
> =20
>  Interleave and Configuration Flexibility
>  ----------------------------------------
> -If providing cross-host-bridge interleave, a CFMWS entry in the CEDT mus=
t be
> -presented with target host-bridges for the interleaved device sets (ther=
e may
> -be multiple behind each host bridge).
> +If providing cross-host-bridge interleave, a CFMWS entry in the
> +Documentation/driver-api/cxl/platform/acpi/cedt.rst
> +must be presented with target host-bridges for the interleaved device se=
ts
> +(there may be multiple behind each host bridge).
> =20
>  If providing intra-host-bridge interleaving, only 1 CFMWS entry in the C=
EDT is
>  required for that host bridge - if it covers the entire capacity of the =
devices
> @@ -193,8 +194,8 @@ different purposes.  For example, you may want to con=
sider adding:
> =20
>  A platform may choose to add all of these, or change the mode based on a=
 BIOS
>  setting.  For each CFMWS entry, Linux expects descriptions of the descri=
bed
> -memory regions in the SRAT to determine the number of NUMA nodes it shou=
ld
> -reserve during early boot / init.
> +memory regions in the Documentation/driver-api/cxl/platform/acpi/srat.rs=
t to
> +determine the number of NUMA nodes it should reserve during early boot /=
 init.
> =20
>  As of v6.14, Linux will create a NUMA node for each CEDT CFMWS entry, ev=
en if
>  a matching SRAT entry does not exist; however, this is not guaranteed in=
 the
> diff --git a/Documentation/driver-api/cxl/platform/example-configurations=
/flexible.rst b/Documentation/driver-api/cxl/platform/example-configuration=
s/flexible.rst
> index 13a97c03e25a..b2559d2de225 100644
> --- a/Documentation/driver-api/cxl/platform/example-configurations/flexib=
le.rst
> +++ b/Documentation/driver-api/cxl/platform/example-configurations/flexib=
le.rst
> @@ -18,7 +18,7 @@ Things to note:
>  * This SRAT describes one-node for each of the above CFMWS.
>  * The HMAT describes performance for each node in the SRAT.
> =20
> -CEDT ::
> +Documentation/driver-api/cxl/platform/acpi/cedt.rst ::
> =20
>              Subtable Type : 00 [CXL Host Bridge Structure]
>                   Reserved : 00
> @@ -137,7 +137,7 @@ CEDT ::
>                      QtgId : 0001
>               First Target : 00000006
> =20
> -SRAT ::
> +Documentation/driver-api/cxl/platform/acpi/srat.rst ::
> =20
>           Subtable Type : 01 [Memory Affinity]
>                  Length : 28
> @@ -223,7 +223,7 @@ SRAT ::
>         Hot Pluggable : 1
>          Non-Volatile : 0
> =20
> -HMAT ::
> +Documentation/driver-api/cxl/platform/acpi/hmat.rst ::
> =20
>                 Structure Type : 0001 [SLLBI]
>                      Data Type : 00   [Latency]
> @@ -263,7 +263,7 @@ HMAT ::
>                          Entry : 0100
>                          Entry : 0100
> =20
> -SLIT ::
> +Documentation/driver-api/cxl/platform/acpi/slit.rst ::
> =20
>       Signature : "SLIT"    [System Locality Information Table]
>      Localities : 0000000000000003
> @@ -276,7 +276,7 @@ SLIT ::
>    Locality   6 : FF FF FF FF FF FF 0A FF
>    Locality   7 : FF FF FF FF FF FF FF 0A
> =20
> -DSDT ::
> +Documentation/driver-api/cxl/platform/acpi/dsdt.rst ::
> =20
>    Scope (_SB)
>    {
> diff --git a/Documentation/driver-api/cxl/platform/example-configurations=
/hb-interleave.rst b/Documentation/driver-api/cxl/platform/example-configur=
ations/hb-interleave.rst
> index fa0885d82deb..9cbf3dd44b0f 100644
> --- a/Documentation/driver-api/cxl/platform/example-configurations/hb-int=
erleave.rst
> +++ b/Documentation/driver-api/cxl/platform/example-configurations/hb-int=
erleave.rst
> @@ -13,7 +13,7 @@ Things to note:
>  * This SRAT describes one-node for both host bridges.
>  * The HMAT describes a single node's performance.
> =20
> -CEDT ::
> +Documentation/driver-api/cxl/platform/acpi/cedt.rst ::
> =20
>              Subtable Type : 00 [CXL Host Bridge Structure]
>                   Reserved : 00
> @@ -48,7 +48,7 @@ CEDT ::
>               First Target : 00000007
>              Second Target : 00000006
> =20
> -SRAT ::
> +Documentation/driver-api/cxl/platform/acpi/srat.rst ::
> =20
>           Subtable Type : 01 [Memory Affinity]
>                  Length : 28
> @@ -62,7 +62,7 @@ SRAT ::
>         Hot Pluggable : 1
>          Non-Volatile : 0
> =20
> -HMAT ::
> +Documentation/driver-api/cxl/platform/acpi/hmat.rst ::
> =20
>                 Structure Type : 0001 [SLLBI]
>                      Data Type : 00   [Latency]
> @@ -80,14 +80,14 @@ HMAT ::
>                          Entry : 1200
>                          Entry : 0400
> =20
> -SLIT ::
> +Documentation/driver-api/cxl/platform/acpi/slit.rst ::
> =20
>       Signature : "SLIT"    [System Locality Information Table]
>      Localities : 0000000000000003
>    Locality   0 : 10 20
>    Locality   1 : FF 0A
> =20
> -DSDT ::
> +Documentation/driver-api/cxl/platform/acpi/dsdt.rst ::
> =20
>    Scope (_SB)
>    {
> diff --git a/Documentation/driver-api/cxl/platform/example-configurations=
/multi-dev-per-hb.rst b/Documentation/driver-api/cxl/platform/example-confi=
gurations/multi-dev-per-hb.rst
> index 6adf7c639490..fa24243968ac 100644
> --- a/Documentation/driver-api/cxl/platform/example-configurations/multi-=
dev-per-hb.rst
> +++ b/Documentation/driver-api/cxl/platform/example-configurations/multi-=
dev-per-hb.rst
> @@ -14,7 +14,7 @@ Things to note:
>  * This CEDT/SRAT describes one node for both devices.
>  * There is only one proximity domain the HMAT for both devices.
> =20
> -CEDT ::
> +Documentation/driver-api/cxl/platform/acpi/cedt.rst ::
> =20
>              Subtable Type : 00 [CXL Host Bridge Structure]
>                   Reserved : 00
> @@ -39,7 +39,7 @@ CEDT ::
>                      QtgId : 0001
>               First Target : 00000007
> =20
> -SRAT ::
> +Documentation/driver-api/cxl/platform/acpi/srat.rst ::
> =20
>           Subtable Type : 01 [Memory Affinity]
>                  Length : 28
> @@ -53,7 +53,7 @@ SRAT ::
>         Hot Pluggable : 1
>          Non-Volatile : 0
> =20
> -HMAT ::
> +Documentation/driver-api/cxl/platform/acpi/hmat.rst ::
> =20
>                 Structure Type : 0001 [SLLBI]
>                      Data Type : 00   [Latency]
> @@ -69,14 +69,14 @@ HMAT ::
>                          Entry : 1200
>                          Entry : 0200
> =20
> -SLIT ::
> +Documentation/driver-api/cxl/platform/acpi/slit.rst ::
> =20
>       Signature : "SLIT"    [System Locality Information Table]
>      Localities : 0000000000000003
>    Locality   0 : 10 20
>    Locality   1 : FF 0A
> =20
> -DSDT ::
> +Documentation/driver-api/cxl/platform/acpi/dsdt.rst ::
> =20
>    Scope (_SB)
>    {
> diff --git a/Documentation/driver-api/cxl/platform/example-configurations=
/one-dev-per-hb.rst b/Documentation/driver-api/cxl/platform/example-configu=
rations/one-dev-per-hb.rst
> index 8b732dc8c5b6..ee65b3364c5b 100644
> --- a/Documentation/driver-api/cxl/platform/example-configurations/one-de=
v-per-hb.rst
> +++ b/Documentation/driver-api/cxl/platform/example-configurations/one-de=
v-per-hb.rst
> @@ -14,7 +14,7 @@ Things to note:
>  * This CEDT/SRAT describes one-node per device
>  * The expanders have the same performance and will be in the same memory=
 tier.
> =20
> -CEDT ::
> +Documentation/driver-api/cxl/platform/acpi/cedt.rst ::
> =20
>              Subtable Type : 00 [CXL Host Bridge Structure]
>                   Reserved : 00
> @@ -62,7 +62,7 @@ CEDT ::
>                      QtgId : 0001
>               First Target : 00000006
> =20
> -SRAT ::
> +Documentation/driver-api/cxl/platform/acpi/srat.rst ::
> =20
>           Subtable Type : 01 [Memory Affinity]
>                  Length : 28
> @@ -88,7 +88,7 @@ SRAT ::
>         Hot Pluggable : 1
>          Non-Volatile : 0
> =20
> -HMAT ::
> +Documentation/driver-api/cxl/platform/acpi/hmat.rst ::
> =20
>                 Structure Type : 0001 [SLLBI]
>                      Data Type : 00   [Latency]
> @@ -108,7 +108,7 @@ HMAT ::
>                          Entry : 0200
>                          Entry : 0200
> =20
> -SLIT ::
> +Documentation/driver-api/cxl/platform/acpi/slit.rst ::
> =20
>       Signature : "SLIT"    [System Locality Information Table]
>      Localities : 0000000000000003
> @@ -116,7 +116,7 @@ SLIT ::
>    Locality   1 : FF 0A FF
>    Locality   2 : FF FF 0A
> =20
> -DSDT ::
> +Documentation/driver-api/cxl/platform/acpi/dsdt.rst ::
> =20
>    Scope (_SB)
>    {

You may want to add explicit anchor text (using relative :doc: links to
lessen typing):

---- >8 ----
diff --git a/Documentation/driver-api/cxl/devices/device-types.rst b/Docume=
ntation/driver-api/cxl/devices/device-types.rst
index f33a40d2284d19..b784aa85abf019 100644
--- a/Documentation/driver-api/cxl/devices/device-types.rst
+++ b/Documentation/driver-api/cxl/devices/device-types.rst
@@ -115,7 +115,7 @@ A Multi-Headed Single-Logical Device (MHSLD) exposes a =
single logical
 device to multiple heads which may be connected to one or more discrete
 hosts.  An example of this would be a simple memory-pool which may be
 statically configured (prior to boot) to expose portions of its memory
-to Linux via Documentation/driver-api/cxl/platform/acpi/cedt.rst
+to Linux via :doc:`CEDT ACPI table <../platform/acpi/cedt>`.

 MHMLD
 ~~~~~
diff --git a/Documentation/driver-api/cxl/linux/access-coordinates.rst b/Do=
cumentation/driver-api/cxl/linux/access-coordinates.rst
index cd6d66cdf9e691..610970874aefdb 100644
--- a/Documentation/driver-api/cxl/linux/access-coordinates.rst
+++ b/Documentation/driver-api/cxl/linux/access-coordinates.rst
@@ -84,9 +84,9 @@ also the index for the resulting xarray.

 The next step is to take the min() of the per host bridge bandwidth and the
 bandwidth from the Generic Port (GP). The bandwidths for the GP is retriev=
ed
-via ACPI tables Documentation/driver-api/cxl/platform/acpi/srat.rst and
-Documentation/driver-api/cxl/platform/acpi/hmat.rst. The min bandwidth are
-aggregated under the same ACPI0017 device to form a new xarray.
+via ACPI tables :doc:`SRAT <../platform/acpi/srat>` and
+:doc:`HMAT <../platform/acpi/hmat>`. The min bandwidth are aggregated under
+the same ACPI0017 device to form a new xarray.

 Finally, the cxl_region_update_bandwidth() is called and the aggregated
 bandwidth from all the members of the last xarray is updated for the
diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentat=
ion/driver-api/cxl/linux/cxl-driver.rst
index b4cb1910added6..c7e0ef80237df8 100644
--- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
+++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
@@ -77,11 +77,13 @@ Root Object` Device Class is found.

 The Root contains links to:

-* `Host Bridge Ports` defined by CHBS in Documentation/driver-api/cxl/plat=
form/acpi/cedt.rst.
+* `Host Bridge Ports` defined by CHBS in :doc:`CEDT table
+  <../platform/acpi/cedt>`.

 * `Downstream Ports` typically connected to `Host Bridge Ports`

-* `Root Decoders` defined by CFMWS in Documentation/driver-api/cxl/platfor=
m/acpi/cedt.rst.
+* `Root Decoders` defined by CFMWS in :doc:`CEDT table
+  <../platform/acpi/cedt>`.

 ::

@@ -151,8 +153,8 @@ and may be one of many `logical devices` presented by a=
 memory device. It
 is still considered a type of `port` in the fabric.

 An `endpoint` contains `endpoint decoders` available for use and the CDAT =
in
-Device's Documentation/driver-api/cxl/devices/uefi.rst used to describe the
-capabilities of the device. ::
+Device's :doc:`UEFI data <../devices/uefi>` used to describe the capabilit=
ies
+of the device. ::

   # ls /sys/bus/cxl/devices/endpoint5
     CDAT        decoders_committed  modalias      uevent
@@ -247,18 +249,18 @@ parameter.
 Root Decoder
 ~~~~~~~~~~~~
 A `Root Decoder` is logical construct of the physical address and interlea=
ve
-configurations present in the CFMWS field of the
-Documentation/driver-api/cxl/platform/acpi/cedt.rst.
-Linux presents this information as a decoder present in the `CXL Root`.  We
-consider this a `Root Decoder`, though technically it exists on the bounda=
ry
-of the CXL specification and platform-specific CXL root implementations.
+configurations present in the CFMWS field of the :doc:`CEDT table
+<../platform/acpi/cedt>`. Linux presents this information as a decoder pre=
sent
+in the `CXL Root`.  We consider this a `Root Decoder`, though technically =
it
+exists on the boundary of the CXL specification and platform-specific CXL =
root
+implementations.

 Linux considers these logical decoders a type of `Routing Decoder`, and is=
 the
 first decoder in the CXL fabric to receive a memory access from the platfo=
rm's
 memory controllers.

 `Root Decoders` are created during :code:`cxl_acpi_probe`.  One root decod=
er
-is created per CFMWS entry in the Documentation/driver-api/cxl/platform/ac=
pi/cedt.rst.
+is created per CFMWS entry in the :doc:`CEDT table <../platform/acpi/cedt>=
`.

 The :code:`target_list` parameter is filled by the CFMWS target fields. Ta=
rgets
 of a root decoder are `Host Bridges`, which means interleave done at the r=
oot
@@ -269,8 +271,8 @@ Only root decoders are capable of `Inter-Host-Bridge In=
terleave`.
 Such interleaves must be configured by the platform and described in the A=
CPI
 CEDT CFMWS, as the target CXL host bridge UIDs in the CFMWS must match the=
 CXL
 host bridge UIDs in the CHBS field of the
-Documentation/driver-api/cxl/platform/acpi/cedt.rst and the UID field of C=
XL
-Host Bridges defined in the Documentation/driver-api/cxl/platform/acpi/dsd=
t.rst.
+:doc:`CEDT table <../platform/acpi/cedt>` and the UID field of CXL
+Host Bridges defined in the :doc:`DSDT table <../platform/acpi/dsdt>`.

 Interleave settings in a root decoder describe how to interleave accesses =
among
 the *immediate downstream targets*, not the entire interleave set.
@@ -534,11 +536,11 @@ granularity configuration.

 At Root
 ~~~~~~~
-Root decoder interleave is defined by CFMWS field of the
-Documentation/driver-api/cxl/platform/acpi/cedt.rst.  The CEDT may actually
-define multiple CFMWS configurations to describe the same physical capacit=
y,
-with the intent to allow users to decide at runtime whether to online memo=
ry
-as interleaved or non-interleaved. ::
+Root decoder interleave is defined by CFMWS field of the :doc:`CEDT table
+<../platform/acpi/cedt>`.  The CEDT may actually define multiple CFMWS
+configurations to describe the same physical capacity, with the intent to =
allow
+users to decide at runtime whether to online memory as interleaved or
+non-interleaved. ::

              Subtable Type : 01 [CXL Fixed Memory Window Structure]
        Window base address : 0000000100000000
diff --git a/Documentation/driver-api/cxl/linux/early-boot.rst b/Documentat=
ion/driver-api/cxl/linux/early-boot.rst
index 309cc6999c6bce..cdd485579e6422 100644
--- a/Documentation/driver-api/cxl/linux/early-boot.rst
+++ b/Documentation/driver-api/cxl/linux/early-boot.rst
@@ -13,8 +13,8 @@ representations of the devices.

 During Linux Early Boot stage (functions in the kernel that have the __init
 decorator), the system takes the resources created by EFI/BIOS
-(Documentation/driver-api/cxl/platform/acpi.rst)
-and turns them into resources that the kernel can consume.
+(:doc:`ACPI tables <../platform/acpi>`) and turns them into resources that=
 the
+kernel can consume.


 BIOS, Build and Boot Options
@@ -71,14 +71,14 @@ NUMA Node Reservation
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

 Linux refers to the proximity domains (:code:`PXM`) defined in the
-Documentation/driver-api/cxl/platform/acpi/srat.rst to create NUMA nodes in
+:doc:`SRAT table <../platform/acpi/srat>` to create NUMA nodes in
 :code:`acpi_numa_init`. Typically, there is a 1:1 relation between
 :code:`PXM` and NUMA node IDs.

 The SRAT is the only ACPI defined way of defining Proximity Domains. Linux
 chooses to, at most, map those 1:1 with NUMA nodes.
-Documentation/driver-api/cxl/platform/acpi/cedt.rst
-adds a description of SPA ranges which Linux may map to one or more NUMA n=
odes
+:doc:`CEDT <../platform/acpi/cedt>` adds a description of SPA ranges which
+Linux may map to one or more NUMA nodes

 If there are CXL ranges in the CFMWS but not in SRAT, then a fake :code:`P=
XM`
 is created (as of v6.15). In the future, Linux may reject CFMWS not descri=
bed
@@ -91,7 +91,8 @@ data for Linux to identify NUMA nodes their associated me=
mory regions.

 The relevant code exists in: :code:`linux/drivers/acpi/numa/srat.c`.

-See Documentation/driver-api/cxl/platform/example-configs.rst for more inf=
o.
+See :doc:`Example Platform Configurations section <../platform/example-con=
figs>`
+for more info.

 Memory Tiers Creation
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -111,12 +112,13 @@ Tier membership can be inspected in ::
   0-1

 If nodes are grouped which have clear difference in performance, check the
-Documentation/driver-api/cxl/platform/acpi/hmat.rst and CDAT
-(Documentation/driver-api/cxl/devices/uefi.rst) information for the CXL no=
des.
-All nodes default to the DRAM tier, unless HMAT/CDAT information is report=
ed
-to the memory_tier component via `access_coordinates`.
+:doc:`HMAT <../platform/acpi/hmat>` and :doc:`CDAT <../devices/uefi>`
+information for the CXL nodes. All nodes default to the DRAM tier, unless
+HMAT/CDAT information is reported to the memory_tier component via
+`access_coordinates`.

-For more, see Documentation/driver-api/cxl/linux/access-coordinates.rst.
+For more, see :doc:`CXL access coordinates documentation
+<../linux/access-coordinates>`.

 Contiguous Memory Allocation
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
diff --git a/Documentation/driver-api/cxl/platform/bios-and-efi.rst b/Docum=
entation/driver-api/cxl/platform/bios-and-efi.rst
index 3c46941b948e4f..f95efacc36de8b 100644
--- a/Documentation/driver-api/cxl/platform/bios-and-efi.rst
+++ b/Documentation/driver-api/cxl/platform/bios-and-efi.rst
@@ -22,7 +22,7 @@ At a high level, this is what occurs during this phase of=
 configuration.

 Much of what this section is concerned with is ACPI Table production and
 static memory map configuration. More detail on these tables can be found
-at Documentation/driver-api/cxl/platform/acpi.rst.
+at :doc:`ACPI tables reference <acpi>`.

 .. note::
    Platform Vendors should read carefully, as this sections has recommenda=
tions
@@ -176,9 +176,8 @@ to implement driver support for your platform.
 Interleave and Configuration Flexibility
 ----------------------------------------
 If providing cross-host-bridge interleave, a CFMWS entry in the
-Documentation/driver-api/cxl/platform/acpi/cedt.rst
-must be presented with target host-bridges for the interleaved device sets
-(there may be multiple behind each host bridge).
+:doc:`CEDT <acpi/cedt>` must be presented with target host-bridges for
+the interleaved device sets (there may be multiple behind each host bridge=
).

 If providing intra-host-bridge interleaving, only 1 CFMWS entry in the CED=
T is
 required for that host bridge - if it covers the entire capacity of the de=
vices
@@ -194,7 +193,7 @@ different purposes.  For example, you may want to consi=
der adding:

 A platform may choose to add all of these, or change the mode based on a B=
IOS
 setting.  For each CFMWS entry, Linux expects descriptions of the described
-memory regions in the Documentation/driver-api/cxl/platform/acpi/srat.rst =
to
+memory regions in the :doc:`SRAT <acpi/srat>` to
 determine the number of NUMA nodes it should reserve during early boot / i=
nit.

 As of v6.14, Linux will create a NUMA node for each CEDT CFMWS entry, even=
 if
diff --git a/Documentation/driver-api/cxl/platform/example-configurations/f=
lexible.rst b/Documentation/driver-api/cxl/platform/example-configurations/=
flexible.rst
index b2559d2de2255b..03cfc8785702bc 100644
--- a/Documentation/driver-api/cxl/platform/example-configurations/flexible=
=2Erst
+++ b/Documentation/driver-api/cxl/platform/example-configurations/flexible=
=2Erst
@@ -18,7 +18,7 @@ Things to note:
 * This SRAT describes one-node for each of the above CFMWS.
 * The HMAT describes performance for each node in the SRAT.

-Documentation/driver-api/cxl/platform/acpi/cedt.rst ::
+:doc:`CEDT <../acpi/cedt>`::

             Subtable Type : 00 [CXL Host Bridge Structure]
                  Reserved : 00
@@ -137,7 +137,7 @@ Documentation/driver-api/cxl/platform/acpi/cedt.rst ::
                     QtgId : 0001
              First Target : 00000006

-Documentation/driver-api/cxl/platform/acpi/srat.rst ::
+:doc:`SRAT <../acpi/srat>`::

          Subtable Type : 01 [Memory Affinity]
                 Length : 28
@@ -223,7 +223,7 @@ Documentation/driver-api/cxl/platform/acpi/srat.rst ::
        Hot Pluggable : 1
         Non-Volatile : 0

-Documentation/driver-api/cxl/platform/acpi/hmat.rst ::
+:doc:`HMAT <../acpi/hmat>`::

                Structure Type : 0001 [SLLBI]
                     Data Type : 00   [Latency]
@@ -263,7 +263,7 @@ Documentation/driver-api/cxl/platform/acpi/hmat.rst ::
                         Entry : 0100
                         Entry : 0100

-Documentation/driver-api/cxl/platform/acpi/slit.rst ::
+:doc:`SLIT <../acpi/slit>`::

      Signature : "SLIT"    [System Locality Information Table]
     Localities : 0000000000000003
@@ -276,7 +276,7 @@ Documentation/driver-api/cxl/platform/acpi/slit.rst ::
   Locality   6 : FF FF FF FF FF FF 0A FF
   Locality   7 : FF FF FF FF FF FF FF 0A

-Documentation/driver-api/cxl/platform/acpi/dsdt.rst ::
+:doc:`DSDT <../acpi/dsdt>`::

   Scope (_SB)
   {
diff --git a/Documentation/driver-api/cxl/platform/example-configurations/h=
b-interleave.rst b/Documentation/driver-api/cxl/platform/example-configurat=
ions/hb-interleave.rst
index 9cbf3dd44b0f62..d0c512b3c0ae99 100644
--- a/Documentation/driver-api/cxl/platform/example-configurations/hb-inter=
leave.rst
+++ b/Documentation/driver-api/cxl/platform/example-configurations/hb-inter=
leave.rst
@@ -13,7 +13,7 @@ Things to note:
 * This SRAT describes one-node for both host bridges.
 * The HMAT describes a single node's performance.

-Documentation/driver-api/cxl/platform/acpi/cedt.rst ::
+:doc:`CEDT <../acpi/cedt>`::

             Subtable Type : 00 [CXL Host Bridge Structure]
                  Reserved : 00
@@ -48,7 +48,7 @@ Documentation/driver-api/cxl/platform/acpi/cedt.rst ::
              First Target : 00000007
             Second Target : 00000006

-Documentation/driver-api/cxl/platform/acpi/srat.rst ::
+:doc:`SRAT <../acpi/srat>`::

          Subtable Type : 01 [Memory Affinity]
                 Length : 28
@@ -62,7 +62,7 @@ Documentation/driver-api/cxl/platform/acpi/srat.rst ::
        Hot Pluggable : 1
         Non-Volatile : 0

-Documentation/driver-api/cxl/platform/acpi/hmat.rst ::
+:doc:`HMAT <../acpi/hmat>`::

                Structure Type : 0001 [SLLBI]
                     Data Type : 00   [Latency]
@@ -80,14 +80,14 @@ Documentation/driver-api/cxl/platform/acpi/hmat.rst ::
                         Entry : 1200
                         Entry : 0400

-Documentation/driver-api/cxl/platform/acpi/slit.rst ::
+:doc:`SLIT <../acpi/slit>`::

      Signature : "SLIT"    [System Locality Information Table]
     Localities : 0000000000000003
   Locality   0 : 10 20
   Locality   1 : FF 0A

-Documentation/driver-api/cxl/platform/acpi/dsdt.rst ::
+:doc:`DSDT <../acpi/dsdt>`::

   Scope (_SB)
   {
diff --git a/Documentation/driver-api/cxl/platform/example-configurations/m=
ulti-dev-per-hb.rst b/Documentation/driver-api/cxl/platform/example-configu=
rations/multi-dev-per-hb.rst
index fa24243968ac9c..a7854a79dbbde9 100644
--- a/Documentation/driver-api/cxl/platform/example-configurations/multi-de=
v-per-hb.rst
+++ b/Documentation/driver-api/cxl/platform/example-configurations/multi-de=
v-per-hb.rst
@@ -14,7 +14,7 @@ Things to note:
 * This CEDT/SRAT describes one node for both devices.
 * There is only one proximity domain the HMAT for both devices.

-Documentation/driver-api/cxl/platform/acpi/cedt.rst ::
+:doc:`CEDT <../acpi/cedt>`::

             Subtable Type : 00 [CXL Host Bridge Structure]
                  Reserved : 00
@@ -39,7 +39,7 @@ Documentation/driver-api/cxl/platform/acpi/cedt.rst ::
                     QtgId : 0001
              First Target : 00000007

-Documentation/driver-api/cxl/platform/acpi/srat.rst ::
+:doc:`SRAT <../acpi/srat>`::

          Subtable Type : 01 [Memory Affinity]
                 Length : 28
@@ -53,7 +53,7 @@ Documentation/driver-api/cxl/platform/acpi/srat.rst ::
        Hot Pluggable : 1
         Non-Volatile : 0

-Documentation/driver-api/cxl/platform/acpi/hmat.rst ::
+:doc:`HMAT <../acpi/hmat>`::

                Structure Type : 0001 [SLLBI]
                     Data Type : 00   [Latency]
@@ -69,14 +69,14 @@ Documentation/driver-api/cxl/platform/acpi/hmat.rst ::
                         Entry : 1200
                         Entry : 0200

-Documentation/driver-api/cxl/platform/acpi/slit.rst ::
+:doc:`SLIT <../acpi/slit>`::

      Signature : "SLIT"    [System Locality Information Table]
     Localities : 0000000000000003
   Locality   0 : 10 20
   Locality   1 : FF 0A

-Documentation/driver-api/cxl/platform/acpi/dsdt.rst ::
+:doc:`DSDT <../acpi/dsdt>`::

   Scope (_SB)
   {
diff --git a/Documentation/driver-api/cxl/platform/example-configurations/o=
ne-dev-per-hb.rst b/Documentation/driver-api/cxl/platform/example-configura=
tions/one-dev-per-hb.rst
index ee65b3364c5bf6..b800713313451b 100644
--- a/Documentation/driver-api/cxl/platform/example-configurations/one-dev-=
per-hb.rst
+++ b/Documentation/driver-api/cxl/platform/example-configurations/one-dev-=
per-hb.rst
@@ -14,7 +14,7 @@ Things to note:
 * This CEDT/SRAT describes one-node per device
 * The expanders have the same performance and will be in the same memory t=
ier.

-Documentation/driver-api/cxl/platform/acpi/cedt.rst ::
+:doc:`CEDT <../acpi/cedt>`::

             Subtable Type : 00 [CXL Host Bridge Structure]
                  Reserved : 00
@@ -62,7 +62,7 @@ Documentation/driver-api/cxl/platform/acpi/cedt.rst ::
                     QtgId : 0001
              First Target : 00000006

-Documentation/driver-api/cxl/platform/acpi/srat.rst ::
+:doc:`SRAT <../acpi/srat>`::

          Subtable Type : 01 [Memory Affinity]
                 Length : 28
@@ -88,7 +88,7 @@ Documentation/driver-api/cxl/platform/acpi/srat.rst ::
        Hot Pluggable : 1
         Non-Volatile : 0

-Documentation/driver-api/cxl/platform/acpi/hmat.rst ::
+:doc:`HMAT <../acpi/hmat>`::

                Structure Type : 0001 [SLLBI]
                     Data Type : 00   [Latency]
@@ -108,7 +108,7 @@ Documentation/driver-api/cxl/platform/acpi/hmat.rst ::
                         Entry : 0200
                         Entry : 0200

-Documentation/driver-api/cxl/platform/acpi/slit.rst ::
+:doc:`SLIT <../acpi/slit>`::

      Signature : "SLIT"    [System Locality Information Table]
     Localities : 0000000000000003
@@ -116,7 +116,7 @@ Documentation/driver-api/cxl/platform/acpi/slit.rst ::
   Locality   1 : FF 0A FF
   Locality   2 : FF FF 0A

-Documentation/driver-api/cxl/platform/acpi/dsdt.rst ::
+:doc:`DSDT <../acpi/dsdt>`::

   Scope (_SB)
   {

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--L/cc5o7PhJNIWkaT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaCBqVwAKCRD2uYlJVVFO
oxAUAP4sx38uPHUp+cgt2UCE9W56lkaPc/9b3vzSvA9CaAA1wgD/V7IyW5HEjmDA
gft/qDvF2E8t+C71jvvB3ddp9e9HUwY=
=BkbK
-----END PGP SIGNATURE-----

--L/cc5o7PhJNIWkaT--
