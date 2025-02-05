Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D03D25A65D
	for <linux-cxl@vger.kernel.org>; Wed,  5 Feb 2025 02:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738721836; cv=none; b=GNe2N1MF8Lh0015rRFBNfTIcH613nJgsB70W3Nf7/QpwCfKVyRDvsU3u9O7lSKnoJm264bCaOPEbhFRJqfVq2pqwP85seSiP6EYkQR99fDxvNLfksWmAv62KvP7/LU/6QfQh39rTltjN/vZbiVuLPsdwX6paQn7lVK1aL0LpJOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738721836; c=relaxed/simple;
	bh=CPlLUYXLI0IgQ1H+q1v8VNFC/v8ZG5uQkGMq9h6f9tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaVVKMcZwDLq0vm1AULkis7Hog6xilg8s1wi/wGlk/rcNkrZBcUdY1pxFwjWnvT79P6YVp/KPK82GnrAQmqCy689xflJYRIUeMiRGIcJp9asa0AnhXj3v9Ae73TDdt8AXAez/eUCxLNQF4sbBA1IZEH2r4Ccd3IDWY8M1N6fhO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Wog+RfI2; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Wog+RfI2"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b6f19a6c04so586051785a.0
        for <linux-cxl@vger.kernel.org>; Tue, 04 Feb 2025 18:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738721833; x=1739326633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gQ4wMumQZupZLc/dhljQZvdj84cqZT9CeaohEOD51F8=;
        b=Wog+RfI2ROXqxVW4hl/py6mW+e/CIBrOu23kIytFdw9QbX7xFmxLEDGuWkuCMdOMLX
         wHvc2P8kHqGCMfVnHfEHOqna0RKceYQLMN9el3qDaY6Pq2soPzZf0O3aUlUfbO0mhxND
         40tnLWpDxl9bU500e8d+T2uC275RpP2qsAbNrA3SyKKXp7Uwk/8RKge6GYDopWKRQ1xd
         dBefFlYbUGEuhw3E73/jRu/dPfsAXzzUyedmCm2j6XMVtKTOexfTOynjzoLV1C4Hh9v0
         JD8eL36XtOQR3ruUXU4ATgddjeEy3l/+ATMVxlLQqCuOYuHsrscd/zcm4lgaZLs/ZvnH
         ZDIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738721833; x=1739326633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQ4wMumQZupZLc/dhljQZvdj84cqZT9CeaohEOD51F8=;
        b=OjlyxF2GpNQBnnFdH2Du6jRf3MWYV+2zPuKlmfsuTM2fg0Ss01ddwYQf8i4ZrIFsWQ
         eq6M4TNcZmpNWVxFyOu69Ijt8748+aiASorAcwvJRc9XQuK2VkADNcSVMmtoP/xI4Ngx
         JqLhpt2D1kjJYWVfrP2WSB7Vs/u6iasFydc4KX7435Ehd/7CI2Cwq1LeGqcMq8lVksP+
         fMUddJgson7cGWE/nkVxg6gSfebT+Mz75vq0/auZKFMeqih+QT9eRV35oqtYyl2i2od5
         mZz9dyJk93DqVZ7AmPCILwA/8EIavMvlnlL+JoiTsGD8TtJ59gDNqi+OCuX6iuBAWjZB
         1JoA==
X-Forwarded-Encrypted: i=1; AJvYcCVShDpKgv0NpbxPsFOOiZkF3/wCqY/tILD0G1WLYn445hDD4nnFyCPKz0XgjqE+XCWa1xjEPM4wb+g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx0NXVprdYilaeN/lJrkKnrT22OFoj8CvCWgFEKDHVRyytAqor
	akOlLhCASmTTXXu9Y/BLdh/v2F1GBp1MelcMPxddxibUnWOXIR5RZUNnqBKjX3zrO+awbHYN/br
	1
X-Gm-Gg: ASbGncuamxooVAHKDjWn9XBjmTZ5E+MNPcRECIhmAF7IwdSwByKPladprKNy6z0P56n
	bQUBpQ3sq8zc2NvH+z0HnNUxs/Smb1Hfz6zaQ/AnZKYMP4pfVkbGVeUFnbCqwtht2AukwKGav24
	/vY0Lr8FLxGogm5v1L+phxaDaDPdoFTN0zbsl7ldCCZrZvw4/XMPK6DOn3Vnl2JQA3fQuNfRzg8
	On1sn+Pu8Fma+sIFhoVstafG/HEGoAZSXlAlI7j5Bsjxb6XTxl8pTFcVvoA6V93IqRBcT0qmzfs
	bft5Kk8rOKyZP+uYyna9uO8HLR7aDMK0NyhJL1U3/Elw4EJqzVSIFo0ErKAT7FqxtNhB89hFaQ=
	=
X-Google-Smtp-Source: AGHT+IGcCYeEGXr7ma2IdlwziuxtLLKn8PauDO/TRhblgjJ2/h/K5GKeyVVeyaZAXnakq4YCgficbw==
X-Received: by 2002:ad4:5f45:0:b0:6e4:227b:c2b0 with SMTP id 6a1803df08f44-6e42fbef82cmr19007526d6.22.1738721832796;
        Tue, 04 Feb 2025 18:17:12 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e254814007sm68655186d6.34.2025.02.04.18.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 18:17:11 -0800 (PST)
Date: Tue, 4 Feb 2025 21:17:09 -0500
From: Gregory Price <gourry@gourry.net>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [LSF/MM] CXL Boot to Bash - Section 1: BIOS, EFI, and Early Boot
Message-ID: <Z6LKJZkcdjuit2Ck@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>


Tossing this out as larger documentation of these steps for comment,
not as a representation of what will show up in the talk.

This is trying to cover the minimum needed information to start
reasoning about the growing complexity of configurations.


Platform / BIOS / EFI Configuraiton
===================================
---------------------------------------
Step 1: BIOS-time hardware programming.
---------------------------------------

I don't want to focus on platform specifics, so really all you need
to know about this phase for the purpose of MM is that platforms may
program the CXL device heirarchy and lock the configuration.

In practice it means you probably can't reconfigure things after boot
without doing major teardowns of the devices and resetting them -
assuming the platform doesn't have major quirks that prevent this.

This has implications for Hotplug, Interleave, and RAS, but we'll
cover those explicitly elsewhere. Otherwise, if something gets mucked
up at this stage - complain to your platform / hardware vendor.


------------------------------------------------------------------
Step 2: BIOS / EFI generates the CEDT (CXL Early Detection Table).
------------------------------------------------------------------

This table is responsible for reporting each "CXL Host Bridge" and
"CXL Fixed Memory Window" present at boot - which enables early boot
software to manage those devices and the memory capacity presented
by those devices.

Example CEDT Entries (truncated) 
         Subtable Type : 00 [CXL Host Bridge Structure]
              Reserved : 00
                Length : 0020
Associated host bridge : 00000005

         Subtable Type : 01 [CXL Fixed Memory Window Structure]
              Reserved : 00
                Length : 002C
              Reserved : 00000000
   Window base address : 000000C050000000
           Window size : 0000003CA0000000

If this memory is NOT marked "Special Purpose" by BIOS (next section),
you should find a matching entry EFI Memory Map and /proc/iomem

BIOS-e820:   [mem 0x000000c050000000-0x000000fcefffffff] usable
/proc/iomem: c050000000-fcefffffff : System RAM


Observation: This memory is treated as 100% normal System RAM

   1) This memory may be placed in any zone (ZONE_NORMAL, typically)
   2) The kernel may use this memory for arbitrary allocations
   4) The driver still enumerates CXL devices and memory regions, but
   3) The CXL driver CANNOT manage this memory (as of today)
      (Caveat: *some* RAS features may still work, possibly)

This creates an nuanced management state.

The memory is online by default and completely usable, AND the driver
appears to be managing the devices - BUT the memory resources and the
management structure are fundamentally separate.
   1) CXL Driver manages CXL features
   2) Non-CXL SystemRAM mechanisms surface the memory to allocators.


---------------------------------------------------------------
Step 3: EFI_MEMORY_SP - Deferring Management to the CXL Driver.
---------------------------------------------------------------

Assuming you DON'T want CXL memory to default to SystemRAM and prefer
NOT to have your kernel allocate arbitrary resources on CXL, you
probably want to defer managing these memory regions to the CXL driver.

The mechanism for is setting EFI_MEMORY_SP bit on CXL memory in BIOS.
This will mark the memory "Special Purpose".

Doing this will result in your memory being marked "Soft Reserved" on
x86 and ARM (presently unknown on other architectures).

You will see Memory Map and iomem entries like so:

BIOS-e820:   [mem 0x000000c050000000-0x000000fcefffffff] soft reserved
/proc/iomem: c050000000-fcefffffff : Soft Reserved

Unless of course:
  1) CONFIG_EFI_SOFT_RESERVE=n in your build config, or
  2) You set the nosoftreserve boot parameter
  3) You kexec'd from a kernel where conditions #1 or #2 are met

In which case you'll get SystemRAM as if EFI_MEMORY_SP was never set.
(#3 was fun to debug, for some definition of fun. Ask me over coffee)

------------------------------------------------------------
First bit of nuanced complexity: Early-Boot Resource Re-use.
------------------------------------------------------------
How are MemoryMap resources managed by a driver after being reserved
during early boot? Example: Hot-(un)plugging a device.

What if we replace said Hot-unplugged device with a device with a new
capacity?  What if the arch/platform code combines two adjacent
regions with similar attributes before creating resources?

Recent work by Nathan Fontenot [1] has been looking to try to address
some of the issues with these Soft Reserved resources and either re-using them
or handing them off entirely to the relative driver for management.

[1] https://lore.kernel.org/linux-cxl/cover.1737046620.git.nathan.fontenot@amd.com/


--------------------------------------------------------------------
The Complexity story up til now (what's likely to show up in slides)
--------------------------------------------------------------------

Platform and BIOS:
   May configure all the devices prior to kernel hand-off.
   May or may not support reconfiguring / hotplug.
BIOS and EFI:
   EFI_MEMORY_SP              - used to defer management to drivers
Kernel Build and Boot:
   CONFIG_EFI_SOFT_RESERVE=n  - Will always result in CXL as SystemRAM
   nosoftreserve              - Will always result in CXL as SystemRAM
   kexec                      - SystemRAM configs carry over to target


--------------------------------------------------------------------
Next Up:
   Driver Management - Decoders, HPA/SPA, DAX, and RAS.
   Memory (Block) Hotplug - Zones, Auto-Online, and User Policy.
   RAS - Poison, MCE, and why you probably want CXL=ZONE_MOVABLE.
   Interleave - RAS and Region Management (Hotplug-ability) 

~Gregory
