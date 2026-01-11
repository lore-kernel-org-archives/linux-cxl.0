Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9784346AF5
	for <linux-cxl@vger.kernel.org>; Sun, 11 Jan 2026 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768155658; cv=none; b=N1JduNG8R74XbJA6/zbro/Cfh2uXJrQIgASfoFqh/ineuatILOICg3PnE1/XzPEXGyxSRz6LC1ipL7sPb20Z/yiUc5XZKsYpVQJDxKVZOvnxgbA1n/YJujsM/Dq6y4f1F7V7aX+yrqRdVGdgzE7cJXhY8JuqDm08jiEPnbpCf7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768155658; c=relaxed/simple;
	bh=SfJrpqITJBqj4x70TkdEEHD+PTaX3wfXpnudD6F/P+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2mVKZNd5IUBgzPi26aoKtmMOdySxoVaOMQBDivhjFI2kilXO3kBnRijon8kMAfJV2yfzdvZ3Iu5s9bljdTeXpeU0hnUrLdEDOsP6S/ELIyKUElcEVMqD/EIOd3hbcH7Fd1HIWjvJyTzJuEVqG6gGmQUOEApvDXMpJKu+Se8jzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vk8BDJyt; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk8BDJyt"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7cdd651c884so3445484a34.1
        for <linux-cxl@vger.kernel.org>; Sun, 11 Jan 2026 10:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768155656; x=1768760456; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aG932MlLjzhGpofJfS2a1eVc1D6C7IY/5zvR3Bf/EEg=;
        b=Vk8BDJytITL52k/twKBejCOnAi85Zm5p3Idlxo/DARGlst9sPFjlIxkl8x21IsSIaM
         jjeuOSjfR6lF8ZsTQ0V6fNNTRKKe2zaD7G3295QOESemB1pnX44uWGqhFJwnObws339h
         yzzPDXcNrEGM5bP9a38gy4YBT0PNDVADPGc4f0VZp3xXKNbbJKb54PsX9Kj5cSSlyzdS
         YtEDbDNLJBwFKR25yV25IKMN9IDGFG+H9wqN23AOgWOpf+dqzmR3WWTGWBNVcpPeboov
         kDvnatondonea20LxKE5CI+I595kyYBwlWF83tIxkoifUZ29XmdEbjDckhYJ2EH8ANVn
         Vzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768155656; x=1768760456;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aG932MlLjzhGpofJfS2a1eVc1D6C7IY/5zvR3Bf/EEg=;
        b=YqXmKZRtnRlUNViRJbdGf0spZV8zrFZz7vytf/IQSgyJ1yGuwmCLhnWOVFBWEXTD+2
         ZpBmcYpeX2omOKmwVAq+fYERCCMhoAkjGcp2gZLA4LRs+ImoF9gGCW+xpuMwaxB3EtQp
         /nCRX5dvB/tvZkqGUODp6Qv1Ntk/JqhdlFF8fhACM5d43dx7JoeGh2VPR3BmkSkpMGYh
         KYO/hKs4s6Z+xUkBnNICMZXWBuEHu91CyAc3v2VH62v9hetvdR6MGBflok17gxtTS1kF
         T6hazD+zaEaaQAQ+49LiuOuayK3OHoMsvsiEz7GH70lqFgWQXsfqffqdpCKkL6neiIc7
         z7Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUq9ae1U+A+wSMSlwi/wAeIbAB+po1VXdtJR6721oHe2gnKHRWQulLXsbVOnPZTvU6HP8PEC6yXqUY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Q9TlCt0Ka1p6GXcEmHnYmpwDJ+4PU9MXQF+Bl3TAc03EFhuR
	P/+N8qyMCc8dot7nEVlt7aebVQ5aG2D0qBGSLq0GiGn5GK0a6SC8jVdV
X-Gm-Gg: AY/fxX79exZhs9HZvSIAIS+d6l0S95nbA+AOt3XJV70AEWDydS4hWlASCMWhoOdoPKv
	uTtZ2DJfyuHr5UeJjxGfPkcRloPuW0tgxBLCKe+NglZ10r6v3SvoBlCbtWnCT9o5VARlFy4p5kE
	Nca0svJEp0zinmmmd8OyQ5vdrT7pGw4oIVa8nLc7uzp8DionbOzy8eSJqoibbY0Olibj95vRWKm
	rdGot6VRE+iZXUJK9skW0ilcCBo1hOtfdkSLIcZVZzsRDf1LJdf+o5zI4m8UuTVeSi7A1tC5Afe
	y2vAfjjbXZcvKjEbAhvgfMDdLjHYL14utlmGmIyVWIMfrS4DMc9cxJK0FTEiG/0DZJ2F5/x93Q9
	L7ahyMmzcgHaNpqIt2KORvXhZCISj0Y8OAvN264++56yvdmAsnagYqcyxRmXud8f7lxVkgLwwO5
	gG+Av4+38HOOYdTb0ocwjRw3m0qCk/EQ==
X-Google-Smtp-Source: AGHT+IHYPDXG5/NvykQQZIk8AUunBR9mK2nY0iKcaE8B6ptLkOnehZCDGmGQeG3pX/n8s5ukcPG3LA==
X-Received: by 2002:a9d:538d:0:b0:7c7:e3b:4860 with SMTP id 46e09a7af769-7ce50b7a52cmr6541341a34.10.1768155655722;
        Sun, 11 Jan 2026 10:20:55 -0800 (PST)
Received: from groves.net ([2603:8080:1500:3d89:cc0c:a1b0:fd82:1d57])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfb21a150asm911499a34.31.2026.01.11.10.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 10:20:55 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Sun, 11 Jan 2026 12:20:52 -0600
From: John Groves <John@groves.net>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, venkataravis@micron.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V3 13/21] famfs_fuse: Famfs mount opt: -o
 shadow=<shadowpath>
Message-ID: <fcwsytw5kd44veyzfel3uxwk2xsi4ywcy354s7rwaj7v4okwf7@ou4nmbo6eixo>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-14-john@groves.net>
 <CAJnrk1bJ3VbZCYJet1eDPy0V=_3cPxz6kDbgcxwtirk2yA9P0w@mail.gmail.com>
 <zcnuiwujbnme46nwhvlwk7bosvd4r7wzkxcf6zsxoyo6edolf7@ufqfutxq4fcp>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zcnuiwujbnme46nwhvlwk7bosvd4r7wzkxcf6zsxoyo6edolf7@ufqfutxq4fcp>

On 26/01/09 06:38PM, John Groves wrote:
> On 26/01/09 11:22AM, Joanne Koong wrote:
> > On Wed, Jan 7, 2026 at 7:34 AM John Groves <John@groves.net> wrote:
> > >
> > > The shadow path is a (usually in tmpfs) file system area used by the
> > > famfs user space to communicate with the famfs fuse server. There is a
> > > minor dilemma that the user space tools must be able to resolve from a
> > > mount point path to a shadow path. Passing in the 'shadow=<path>'
> > > argument at mount time causes the shadow path to be exposed via
> > > /proc/mounts, Solving this dilemma. The shadow path is not otherwise
> > > used in the kernel.
> > 
> > Instead of using mount options to pass the userspace metadata, could
> > /sys/fs be used instead? The client is able to get the connection id
> > by stat-ing the famfs mount path. There could be a
> > /sys/fs/fuse/connections/{id}/metadata file that the server fills out
> > with whatever metadata needs to be read by the client. Having
> > something like this would be useful to non-famfs servers as well.
> 
> The shadow option isn't the only possible way to get what famfs needs,
> but I do like it - I find it to be an elegant solution to the problem.
> 
> What's the problem? Well, for that you need to know some implementation 
> details of the famfs userspace. For the *structure* of a mounted file 
> system, famfs is very passthrough-like. The structure that is being 
> passed through is the shadow file system, which is an actual file system 
> (usually tmpfs).  Directories are just directories, but shadow files 
> contain yaml that describes the file-to-dax map of the *actual* file. 
> On lookup, the famfs fuse server (famfs_fused), rather than stat the 
> file like passthrough, reads the yaml and decodes the stat and fmap info 
> from that.
> 
> One other detail. The shadow path must be known or created (usually
> as a tmpdir, to guarantee it starts empty) at mount time. The kernel
> knows about it through "-o shadow=<path>", but otherwise doesn't use
> it. The famfs fuse server receives the path as an input from 
> 'famfs mount'. The problem is that pretty much every famfs-related
> user space command needs the shadow path.
> 
> In fact the the structure of the mounted file system is at 
> <shadow_path>/root.  Also located in <shadow path> (above ./root) is a 
> unix domain socket for REST communication with famfs_fused. We have 
> plans for other files at <shadow path> and above ./root (mount-specific 
> config options, for example).
> 
> Playing the famfs metadata log requires finding the shadow path,
> parsing the log, and creating (or potentially modifying) shadow files
> in the shadow path for the mount.
> 
> So to communicate with the fuse server we parse the shadow path from
> /proc/mounts and that finds the <shadow_path>/socket that can be used
> to communicate with famfs_fused. And we can play the metadata log
> (accessed via MPT/.meta/.log) to <shadow_path>/root/...
> 
> Having something in sysfs would be fine, but unless we pass it into
> the kernel somehow (hey, like -o shadow=<shadow path>), the kernel
> won't know it and can't reveal it.
> 
> A big no-go, I think, is trying to parse the shadow path from the
> famfs fuse server via 'ps -ef' or 'ps -ax'. The famfs cli etc. might
> be running in a container that doesn't have access to that.
> 
> Happy to discuss further...

After all that blather (from me), I've been thinking about resolving
mount points to shadow paths, and I came to the realization that it's
actually easy to enable retrieving the shadow path from the fuse
server as an extended attribute.

I implemented that this morning, and it appears to be passing all tests.
So I anticipate that I'll be able to drop this patch from the series
when I send V4 - which should be in the next few days unless discussion
heats up in the mean time.

Thinking back... when I implemented the '-o shadow=<path>' thingy
more than a year ago, I still had a *lot* of unsolved problems to 
tackle. Once I had "a solution" I moved on - but the xattr idea looks
solid to me (though if anybody can point out flaws, I'd appreciate it).

(there's an Alice's Restaurant joke in there somewhere if you squint,
about not having to take out the garbage for a long time, but probably 
only for old people like me...)

Regards,
John

[ ... ]

