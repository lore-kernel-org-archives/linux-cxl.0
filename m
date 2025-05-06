Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B5B139E
	for <linux-cxl@vger.kernel.org>; Tue,  6 May 2025 23:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746572795; cv=none; b=mRPjMlH3EEUeOLBVHZ63wPP/SCEt+vILTwk1P0gLCi9WbTcdxjm/nNQh1dSgBVUdSxyG6PfN4GmTISOzgVKh+t7Ul/ONJXCs82fdPAG3c/wAGO/+JppgcgflOyjSx58S2R9m1YbYGbqKnpj41rcNX4r8X0K3aVB8z2xGVNyexrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746572795; c=relaxed/simple;
	bh=AkWTf635RjG0EvzFpzLnPFZugQ89hkoZEH4JSEwN0ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PdXuB7FtIecyjWrvy8NfT1uf5EBtwVBYx3I+c5qcH8kMiOkjcbbD/C854KrUfP7gAnD+6WczlavEdoCBvkx7LqEYfMPw6ajhYteb3eaYM1OC3Uz+iDO8ZnF/9byUklkuKBBniv/UeGupzs7EHZD+R+7bFGtDXtZP30SQbPeioiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ltMMkir9; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ltMMkir9"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c5e2fe5f17so687985285a.3
        for <linux-cxl@vger.kernel.org>; Tue, 06 May 2025 16:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1746572792; x=1747177592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jMzOedZBUFQh6ZOzmCW4ghlDT1S6oF17/0z00FndM84=;
        b=ltMMkir91qDPV3NyGesMnX9DIlK4Nynun0G4iANXsHtee4tkC/GqUKj7ii1kFcqBf4
         IlpHUUvbnljkBM6RtO5JSIJXix8BaAS0gzHqpUsznN/YIZiLV4Jl5+hsnR3c4AUzflN+
         U/cuF9omvO1GJAWmN6jQ9/0bd8MbiMobNkb8r+zKG2HHn77vtzq7zjMgIDKkxERE5NK8
         fmkCi83BEolUSpV89YO4DLTUGt5+VxGxhUaUP2XCrQq+XVyfqBFN6+9ZlG3hw2c0WjEG
         62FBVZ2hxPXlw6w9SU0dEk5sq3CeoSw9s3m/QGprf856/RiOm6q6B4ezIztJvbivwvWt
         0/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746572792; x=1747177592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMzOedZBUFQh6ZOzmCW4ghlDT1S6oF17/0z00FndM84=;
        b=i6PX+adXWetUKJPXJunq2wFKHjbAo5PGLQk2l6KGgegwwRjzxEkwaZ3MMrECjcPT32
         5ynLjaCrxiMEYNeC51NkW+SstqSYrF5boBXw6a04VgF3xRBDUCW/DzWm1KyDbuy3sUCH
         gt0J1RIZBt3sMk2eX/yOSfcj+VJHY4JavEaA9MfcMXRUCXlcJ2BPsc/g0vBe7IgsGzGn
         RLa6u5xALYAM0wckv6qCKI/JwgUo1DSTvOY4TFyDrC5CdUJ4v0xVJHK33wPQ7ZHoNLby
         eOtUg+/4iFlzwmxU+alpyu3FtHQYXpmm0NjQYMCPjWNkqf6VOTypVqGsiVBTuXAYp3b4
         wl9A==
X-Gm-Message-State: AOJu0YyWhkG+Ge791ru9qXxvL1sUAtaTN2WA/HQwlf3lcru9AN4IQSs1
	s0JMnf2Sp1jAyaOc1os8raonH0Z9BwO+T75HkH5s+dTIjOsD5fcij99tdFVBhk8=
X-Gm-Gg: ASbGncta4AFFdIg0bCOi+a6+RxrImRCyhqQMOfmIq6tsduJCDZ4gvH3x11dJh05nTXx
	bit+OL1k9/EOFjBIlDSwxQehQtfhcdMGc5fnVecRsSXVQBHBG5gQ8ROXsMAjaEi4efIEFbGescl
	vR2T+jM9GyelTPwP6BpynzLvBXD82at2FxClhA1g/1XuIgkr8fTz7eHx/is7cPQ9BJadoG5EyT4
	mHHKuVIWLfZ9SQaMDE/35jmTDS4cw1npQ06SFqxCL7JlXpzuk3/f8JJaD1aHrnnE5MGFUFzGwbC
	DKiWAOjOXTKiiUpldvo9Xo26xzIhoZs/Ch/x4IfF5P+0kCdXNMwn64JEKL65itKRkgW+R4X978T
	qUmpP4+lXZrQgzt5Dl/WA
X-Google-Smtp-Source: AGHT+IFHH0FvrhCCJDSr9P751dSZJYI7LDjUr7c/DSSKJlfVzJvDae2X802XdK+1BLRbg8tORhZb0Q==
X-Received: by 2002:a05:6214:dcd:b0:6f4:c824:9d3d with SMTP id 6a1803df08f44-6f542aad789mr18656576d6.37.1746572792237;
        Tue, 06 May 2025 16:06:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f5427d40b9sm3559536d6.118.2025.05.06.16.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 16:06:31 -0700 (PDT)
Date: Tue, 6 May 2025 19:06:29 -0400
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
Subject: Re: [PATCH v8 00/16] Enable CXL PCIe port protocol error handling
 and logging
Message-ID: <aBqV9UCF6dQFtcyP@gourry-fedora-PF4VCD3F>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327014717.2988633-1-terry.bowman@amd.com>

On Wed, Mar 26, 2025 at 08:47:01PM -0500, Terry Bowman wrote:
> This patchset updates CXL Protocol Error handling for CXL Ports and CXL
> Endpoints (EP). The reach of this patchset grew from CXL Ports to include
> EPs as well because updating the handling for all devices is preferable
> over supporting multiple handling paths.
> 
> This patchset is a continuation of v7 and can be found here:
> https://lore.kernel.org/linux-cxl/20250211192444.2292833-1-terry.bowman@amd.com/
> 

I've been testing this for stability on a fair number of boxes for some
time - backported to v6.13. Haven't seen any major issues related to
this set in that time. Outside my normal wheelhouse, but for the sake
of runtime stability:

Tested-by: Gregory Price <gourry@gourry.net>

Trying to get more explicit testing feedback from RAS folks.

(note: there appears to be some conflicting changes in v6.15-rc4+ that
a bit outside my current timeline to forward port and test.)

~Gregory
