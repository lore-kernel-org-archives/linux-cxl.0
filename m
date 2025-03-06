Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED9823C8AA
	for <linux-cxl@vger.kernel.org>; Thu,  6 Mar 2025 23:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741305380; cv=none; b=EifAUm9XN8ylrXV9/epQX6KzyoWH20NZPze3Br57TgW/IuC+hZudmr/uqvWDaDhCl9IKIv59hqkT3s0d7H1d/97vYBFjjN0yLZBeuvnjoqNQ+/kyyE4RtFGZP1JI+8cJSqrGTUd/yJUlBZ5lXqnPsNQbhkVm8ntPhqqB6HA8HNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741305380; c=relaxed/simple;
	bh=EDnut2JJw9QS/vdLIDWZgoog/uv+W8+/FbSRiwqOeC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAl76lV6Pjc71HdNWDHX/o6ZjLvgIvgF5AIcdMQLMUk8iG+vTt6JsKUbOjQKH8Sz92gmfbQHnYBuxwbxlkZW1fXzNDneO419DopFZzZmmXiFRKb1pVuSs8+c+m5xuraofM1jE1HLbSuYemYDIt8Mbg4RtnNlxok2qyr2uJNDNuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=lDVTKEa+; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="lDVTKEa+"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-474e0bd966dso10767811cf.0
        for <linux-cxl@vger.kernel.org>; Thu, 06 Mar 2025 15:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1741305376; x=1741910176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8SxknEtouNK3Zjilzhs/nL72q1E1f2BQDuWYXogJJkI=;
        b=lDVTKEa+F3tj7cXw2K6Bghl1Dg1D/gefEUD5zdYV/+TT8Kmzhpl6GTlKFoFVnK18Rr
         am+jPCJodvCnlInvcXyJELD8aGYd0LZ8aseV44WWoiHYlVOJwniZSYJqgCknAkZor2j7
         /f9CyA7Vz8ACTT+5giPPOeqt4zuvKRzl210uQHTTuqKRxq8oII740r8AEB4QtMRE66Uq
         9bIkl91YKqOFqcw7LuxzxuZeK6Ce59ne0uzXlhddu1euHHcQ5lC5nmK2xDvoTZ3i/Oge
         rXfk8ZBliB+LMe+u25nnXU2dLNgX5u1Rle147QuxLKhBtGlRcz7AbO39ihiuaCzPNUQ8
         puFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741305376; x=1741910176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SxknEtouNK3Zjilzhs/nL72q1E1f2BQDuWYXogJJkI=;
        b=RbmuzyH3SOR8KtdQuVB7gSJxxErpEbmS3xBX/PgjAOEuF52f5m0drkaQaLU/I5/0pj
         f5/0k1UN6K09r+FeUP4T0icuRKpM4twutUwtKZU+crujIKgzUp/wubFPf1gGxMBaUyHN
         8ieKZlyeZkLzZMcmWxToJLTwFLlwYOH9hWpmDQwjp/msaa4I+BZHvBbqdvFi7s+9mmVI
         UcuOkDGMebWswesemkdJzC1EisOW/D6DYYurqdrINoDZJ7pOM3W1XM0muSTXQOzA3k8A
         e/PzUnmbsJlKzLOcS//7bj35IM/CBDAYqhbjTm84QLGnOEVjvf9Q0d2kJzkjQFkHfAG2
         OxAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqzW6hJqeXb93BwC8merNz/6DgBTf3v2sZhSI0SEMa8a3CgtXk44miemB5Aoy3Dd6eoSEg1GJwRK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6T8XsjT7GR18sXNDLTDRWDaYEkUufKNZ9uoGwNzCeJ3zg+7GA
	vI7i98GgGzmfVVsjZ7+XB5QJpP5JXkj5jpydvbm3UwCmM7CtcsS+Q3gWiOpzzaNuS5a2agbl4tm
	p
X-Gm-Gg: ASbGncuddAQ8AYKi74nDFIDF3NcNnUVASzZxVuQya/eLQnoS88qSmE40n7U0yClgRL/
	tdxZTkoNvsRShejKIwm1E8XUAbjvQL0qZB1yO6PC1m69jOc6BQeqMT2MAlpm9NUM3SBedy9GHQL
	JkIlPWAIhsCCf+6e49NP0tMIIDDnQcj3KphkQglzxRGb+BfFnxDzwzGjl8SzpLkkrDi+Eg4jeJb
	C5fQ6V2SX+AqCPcX0Z0cg8ua8f53+RjGMJzVymPNwwX0Izt9VBWjILGn08BPZNp6EU4Fk1C8LTw
	8mwSSCvQSPrCj8Kh6p3oIOU2jOOzTrjycjOE18rp8KIO2Na0aFEEQxuxzELrdWGFVPoppXOqETu
	R/eCdQyVHmDlSRESqNFMvL/ZwLzw=
X-Google-Smtp-Source: AGHT+IHMfvSB5jDUQA+ycqlh2nLaumrbN/QnnIspplIKXIwSEH68cURXntQcFrU/O3HWCHFOeXosag==
X-Received: by 2002:ad4:500c:0:b0:6e6:6c7c:984a with SMTP id 6a1803df08f44-6e9006776admr10608846d6.29.1741305375656;
        Thu, 06 Mar 2025 15:56:15 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707c39dsm12780056d6.23.2025.03.06.15.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 15:56:15 -0800 (PST)
Date: Thu, 6 Mar 2025 18:56:13 -0500
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: CXL Boot to Bash - Section 2a (Drivers): CXL Decoder Programming
Message-ID: <Z8o2HfVd0P_tMhV2@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z6OMcLt3SrsZjgvw@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6OMcLt3SrsZjgvw@gourry-fedora-PF4VCD3F>

I decided to dig into decoder programming as as an addendum to the
Driver section - where I said I *wouldn't* do this. It's important
though, when discussing interleave. So alas, we should at least have
some base understanding of what the heck decoders are actually doing.

This is not a regutitation of the spec, you can think of it closer to
a "Theory of Operation" or whatever.  I will show discrete examples of
how ACPI tables, system memory map, and decoders relate.

----------------------------------------
Definitions: Addresses and HDM Decoders.
----------------------------------------

An HDM Decoder can be thought shorthand as a "routing" mechanism,
where the a Physical Address is used to determine one of:

  1) Fabric routing (i.e. which pipe to send a request down)
  2) Address translation (Host to Device Physical Address)

In section 2, I referenced a simple device-to-decoder mapping:

    root    ---  decoder0.0   -- Root Port Decoder
     |               |
   port1    ---  decoder1.0   -- Host Bridge Decoder
     |               |
  endpoint0 ---  decoder2.0   -- Endpoint Decoder

Barring any special innovations (cough) - endpoint decoders should
be the only decoders that actually "Translation" addresses - at least
for basic volatile memory devices.

All other decoders (Root, Host Bridge, Switch, etc) should simply
forward DMA requests with the original Physical Address intact to
the correct downstream device.

For extra confusion, there are now 3 "Physical Address" domains

System Physical Address (SPA)
  The physical address of some location according to linux.
  This is the address you see in the system memory map.

Host Physical Address   (HPA)
  An abstract address used by decoders (I'll explain later)

Device Physical Address (DPA)
  A device-local physical address (e.g. if a device has 1TB of
  memory, it's DPA range might be 0-0x10000000000)


----------------------------
DMA Routing (No Interleave).
----------------------------
Ok, we have some decoders and confusing physical address definitions,
how does a DMA actually go from processor to DRAM via these decoders?

Lets consider our simple fabric with 256MB of memory at SPA base 4GB.

Lets assume this was all set up statically by BIOS.  We'd have the
following CEDT CFMWS (See Section 0 - ACPI) and decoder programming.

```
CEDT
           Subtable Type : 01 [CXL Fixed Memory Window Structure]
                Reserved : 00
                  Length : 002C
                Reserved : 00000000
     Window base address : 0000000100000000   <- Memory Region
             Window size : 0000000010000000   <- 256MB
Interleave Members (2^n) : 00                 <- Not interleaved

Memory Map:
  [mem 0x0000000100000000-0x0000000110000000] usable    <- SPA

Decoders
  root    ---  decoder0.0   -- range=[0x100000000, 0x110000000]
   |               |
 port1    ---  decoder1.0   -- range=[0x100000000, 0x110000000]
   |               |
endpoint0 ---  decoder2.0   -- range=[0x100000000, 0x110000000]
```

When the CPU accessed an address in this range, the memory controller
will send the request down the CXL fabric. The following steps occur:

  0) CPU accesses SPA(0x101234567)

  1) root decoder identifies HPA(0x101234567) is valid and forwards
     to host bridge associated with that address (port 1)

  2) host bridge decoder identifies HPA(0x101234567) is valid and
     forwards to endpoint associated with that address (endpoint0)

  3) endpoint decoder identifies HPA(0x101234567) is valid and
     translates that address to DPA(0x01234567).

  4) The endpoint device uses DPA(0x01234567) to fulfill the request.

In this scenario, our endpoint has a DPA range of (0, 0x10000000),
but technically DPA address space is device-defined and may be sparse.

As you can see, the root and host bridge decoders simply "route" the
access to the next appropriate hop, while the endpoint decoder actually
does the translation work.


What if instead, we had two 256MB endpoints on the same host bridge?

```
CEDT
           Subtable Type : 01 [CXL Fixed Memory Window Structure]
                Reserved : 00
                  Length : 002C
                Reserved : 00000000
     Window base address : 0000000100000000   <- Memory Region
             Window size : 0000000020000000   <- 512MB
Interleave Members (2^n) : 00                 <- Not interleaved

Memory Map:
  [mem 0x0000000100000000-0x0000000120000000] usable  <- SPA

Decoders
                            decoder0.0
                  range=[0x100000000, 0x120000000]
                                |
                            decoder1.0
                  range=[0x100000000, 0x120000000]
                  /                              \
            decoded2.0                        decoder3.0
  range=[0x100000000, 0x110000000]   range=[0x110000000, 0x120000000]
```

We still only have a single root port and host bridge decoder that
covers the entire 512MB range, but there are now 2 differently
programmed endpoint decoders.

This makes the routing a little more obvious.  The root and host bridge
decoders cover the entire SPA space (512MB), while the endpoint decoders
only cover their own address space (256MB).

The host bridge in this case is responsible for routing the request to
the correct endpoint.


What if we had 2 endpoints, each attached to their own host bridges? 
In this case We'd have 2 root ports and host bridge decoders.

```
CEDT
           Subtable Type : 01 [CXL Fixed Memory Window Structure]
                Reserved : 00
                  Length : 002C
                Reserved : 00000000
     Window base address : 0000000100000000   <- Memory Region 1
             Window size : 0000000010000000   <- 256MB
Interleave Members (2^n) : 00                 <- Not interleaved
            First Target : 00000007           <- Host Bridge _UID

           Subtable Type : 01 [CXL Fixed Memory Window Structure]
                Reserved : 00
                  Length : 002C
                Reserved : 00000000
     Window base address : 0000000110000000   <- Memory Region 1
             Window size : 0000000010000000   <- 256MB
Interleave Members (2^n) : 00                 <- Not interleaved
            First Target : 00000006           <- Host Bridge _UID

Memory Map - this may or may not be collapsed depending on Linux arch
  [mem 0x0000000100000000-0x0000000110000000] usable  <- System Phys Address
  [mem 0x0000000110000000-0x0000000120000000] usable  <- System Phys Address

Decoders
            decoder0.0                     decoder1.0   - roots
    [0x100000000, 0x110000000]     [0x110000000, 0x120000000]
                |                              |
            decoder2.0                     decoder3.0   - host bridges
    [0x100000000, 0x110000000]     [0x110000000, 0x120000000]
                |                              |
            decoder4.0                     decoder5.0   - endpoints
    [0x100000000, 0x110000000]     [0x110000000, 0x120000000]
```

This scenario looks functionally same as the first - with two distinct,
non-overlapping sets of decoders (any given SPA may only be services by
one device).  The platform memory controller is responsible for routing
the address to the correct root decoder.

In Section 4 (Interleave) we'll discuss a bit how the interleave is
accomplished - as this depends whether you are interleaving across
host bridges (aggregation) or within a host bridge (bifurcation).



---------------------------------------------
Nuance: Host Physical Address... translation?
---------------------------------------------

You might have noticed that all the addresses in the examples I showed
are direct subsets of their parent decoder address ranges.  The root is
assigned a System Physical Address according to the system memory map,
and all decoders under it are a subset of that range.

You may have even noticed routing steps suddenly change from SPA to HPA

  0) CPU accesses SPA(0x101234567)

  1) root decoder identifies HPA(0x101234567) is valid and forwards
     to host bridge associated with that address (port 1)

So what the heck is a "Host Physical Address"?
Why isn't everything just described as a "System Physical Address"?

CXL HDM decoders *definitionally* handle HPA to DPA translations.

That's it, that's the definition of an HPA.

On MOST systems, what you see in the memory map is an SPA, and SPA=HPA,
so all the decoders will appear to be programmed with SPA.  The platform
MAY perform translation before a request is routed to decoder complex.

I will cover an example of this in-depth in an interleave addendum.

So the answer is that some ambiguity exists regarding whether platforms
can/should do translation prior to HDM decoders even being utilized.  So
for the sake of making everything more complicated and confusing for very
little value:

1) decoders definitionally do "HPA to DPA" translation
2) most of the time "SPA=HPA"
3) so decoders mostly do "SPA to DPA" translation

If you're confused, that's ok, I was too - and still am.  But Hopefully
between this section and Section 4 (Interleave) we can be marginally
less confused together.


-----------------------------------------------
Nuance: Memory Holes and Hotplug Memory Blocks!
-----------------------------------------------
Help, BIOS split my memory device across non-contiguous memory regions!

```
CEDT
           Subtable Type : 01 [CXL Fixed Memory Window Structure]
                Reserved : 00
                  Length : 002C
                Reserved : 00000000
     Window base address : 0000000100000000   <- Memory Region 1
             Window size : 0000000080000000   <- 128MB
Interleave Members (2^n) : 00                 <- Not interleaved
            First Target : 00000007           <- Host Bridge _UID

CEDT
           Subtable Type : 01 [CXL Fixed Memory Window Structure]
                Reserved : 00
                  Length : 002C
                Reserved : 00000000
     Window base address : 0000000110000000   <- Memory Region 1
             Window size : 0000000080000000   <- 128MB
Interleave Members (2^n) : 00                 <- Not interleaved
            First Target : 00000007           <- Host Bridge _UID

Memory Map
  [mem 0x0000000100000000-0x0000000107FFFFFF] usable  <- SPA
  [mem 0x0000000108000000-0x000000010FFFFFFF] reserved
  [mem 0x0000000110000000-0x0000000118000000] usable  <- SPA
```

Take a breath. Everything will be ok. 

You can have multiple decoders at each point in the decoder complex!
(Most devices should implement for multiple decoders).

```
Decoders
                              Root Port 0
                             /          \
                    decoder0.0          decoder0.1
    [0x100000000, 0x108000000]          [0x110000000, 0x118000000]
                             \          /
                            Host Bridge 7
                             /          \
                    decoder1.0          decoder1.1
    [0x100000000, 0x108000000]          [0x110000000, 0x118000000]
                             \          /
                              Endpoint 0
                             /          \
                    decoder2.0          decoder2.1
    [0x100000000, 0x108000000]          [0x110000000, 0x118000000]
```

If your BIOS adds a memory hole, it better also use multiple decoders.

Oh, wait, Section 2 and Section 3 allude to hotplug memory blocks
having size and alignment issues!

If your BIOS adds a memory hole, it better also do it on Linux hotplug
memory block alignment (2GB on x86) or you'll lose 1 hotplug memory
block of capacity per CFMWS.

Oi, talk about some rough edges, right? :[

---------------------------------------
Nuance: BIOS vs OS Programmed Decoders.
---------------------------------------
The driver can (and does) program these decoders.  However, it's
entirely normal for BIOS/EFI to program decoders prior to OS init.

Earlier in section 2 I said:
  Most associations built by the driver are done by validating decoders

What I meant by this is the driver does one of two things with decoders:

   1) Detects BIOS programmed decoders and sanity checks them.
      If an unexpected configuration is found, it bails out.
      This memory is not accessible if EFI_MEMORY_SP is set.

   2) Provide an interface for user policy configuration of the decoders

For the most part, the mechanism is the same.  This carve-out is to tell
you if something isn't working, you should check whether the BIOS/EFI or
driver programmed the decoders. It will help debug the issue quicker.

        In my experience, it's USUALLY a bad ACPI table.

This distinction will be more important in Section 4 (Interleave) when
we discuss Inter-Host-Bridge and Intra-Host-Bridge interleave.

~Gregory
