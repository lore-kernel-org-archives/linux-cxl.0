Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB583126D6
	for <linux-cxl@vger.kernel.org>; Sun, 23 Aug 2026 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787503401; cv=none; b=GVezdPpqlGwfYp7RsBgjWEuDcKU4EBKO99b6sUcYSQ5DVAYClk43Ih2FrFH6YsLP+pguDbLL9L86s3nFQEcWJjjbGBsrSl/tSUlwXpk8iyHQX5fh3z7O/bC5kQmMCaAVrDH2j/PJcSEMpV4wSz0gBcpkPuFhEXRycwxlS0r0XOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787503401; c=relaxed/simple;
	bh=pWDzkQYpINPFTZeR8thS8nOa7PK6nZSbqUQipGA4xXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXjpRPBZf5UTb4MIb0bGkP7lLIOXQvx0H6977tfO7kuMEEZsatKgZS8yIxYxRYoxPXhP5WFsh8AOt0REwflp4UsdnGlleC0aGIgGszZ7Iaq7qKb/pxFJowhl6DuU1qc0ViSaqJNnRaNYBX7A3a6C0Lf9UWl4IrTlTXNCbJ1bNfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=D3oYCTlz; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="D3oYCTlz"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-52d8679c149so22887761cf.2
        for <linux-cxl@vger.kernel.org>; Sun, 23 Aug 2026 09:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1787503398; x=1788108198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4EA5wtk151L22kFWX4iHeihngZ8TcErsEBYYtEmRpXE=;
        b=D3oYCTlz7ZV/CP8G0eG7QNXAoBrIdfkDLHRo+V+aL5ugG28nejEPsP1eNMKS/brxA1
         WeW8zr3GnTTPNXbO+bYNvs09T0J/cnUU+zlsIF7Fqd8aa02uhuwWO1ZM8EvgyE4k0Z/p
         6gfNs4RnxepRMu4lJr093Kr2yX/067r54D4+Eg7QVN4z+tD2qGKKihOEEmcmecOoQ6ed
         3HwpG7ytChYL/0RILqtER+MvdyCH8C0rJWP3pePI6O1VwSkZHuaqhJWjSM05KHRInsED
         vkbylTcdZmmN2ysybcTKO5NM8OxpeUjplAheXrTpkM/8fUg8/znHDMt/UXkvdyAKTHyM
         fgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787503398; x=1788108198;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4EA5wtk151L22kFWX4iHeihngZ8TcErsEBYYtEmRpXE=;
        b=qYIHFW67vHq00wJymilffLjhTCPUXLSzB3Ue67GT8gqTWeILulwNiVIrYcrC23b8us
         dJVT2uF0LDZdXHy6+U/f2DUd/4H2QI/JF2Qpv1CWew8KuneGnjJmHVvuKycLNCtaDvDU
         lxHCtztRPRlbtPb4uNaqSnZF7AEeKCAJqh0uwtrojVlqcS1ZE0rK+02m5pgOx1EGFR4h
         TmV6Uemm/4FbGns2UxJj+FwoICc2FsG9IirVWpeVHZFPiW7BICkmftwymUS3PsnKre/1
         K521Gj4l1ELiCFvY4NS7Tt2x/fzUr9wGrm5CBY+MY43ZK6WeHK0rKnhhngHmI9rISjo/
         ZTiw==
X-Forwarded-Encrypted: i=1; AHgh+RqxNIYBSTbVAE4+PbldquQH9e69pibSKWlUuHU8NDwNq0bKW/hNNtafmZyj007zZ4HWSdF/7XFfRCw=@vger.kernel.org
X-Gm-Message-State: AFuF++kltYbNHbPSa4cB4FX+v3r3emoUveOuWstPSthWHTAxBhrfJbDH
	rK/T1TfCqDf365tZW+i3CsqwS/rbSwqxW3WH4gLnR82wzVzmlEZRmCiAcwjntXU0zk4=
X-Gm-Gg: AR+sD13N+nPOvY18pp5DJH6TRTsvHkd3DTSwZhyBWgpU89Xzfe3QcOTiUdfx5Hi8gwb
	b7sjNF4Kmsm4tj8j6G/RJXoQm4Em6WxDpWQSPgikWPzobO/TyUZLkxUxh/IIaU5xC+Hxbi3LcYq
	o7oJ+TqKUwTIzraM5nt8rMF4x4ktI2eTankoWy7x+C3/INEJqmnvD7w6MAYut8Z8Y215hP5d9aZ
	FFoCsacHy+3n0G8IyMMSBo1S262oUi4pG0ybbWWySqU7q3bGxrfMC70pU3EqrzsNeloHQWsbUir
	4jaPUSlaZZSEaki2faxcsbh2jUcAcRwEwDEkkn2shxqLe1VKcGyqbk7+ZOzC8yg0jHSozfEfX5Z
	AqPtE9fIVDJWrcZuhtXxqe6HWnKgGRQUN2ZHaix4C2g3qQiddDBN38xizrMgJEpo/A/sJxF1j9Z
	89jKKRi4a0gzw6Cd4TTJ59LbPGz1QxvGB/iYCIAl5PysqxsMpAD01PSTo+sTTteUaSMImYJxdfF
	S4XAsdlLe0mp3zLpigObt//kAhGrIFfdRz+BxnJULL/TxZlLTs5jwU=
X-Received: by 2002:a05:622a:90e:b0:51c:1fd1:e755 with SMTP id d75a77b69052e-52df59e7e7amr219365661cf.36.1787503398278;
        Sun, 23 Aug 2026 09:43:18 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c9361720bsm41074616d6.21.2026.08.23.09.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 09:43:17 -0700 (PDT)
Date: Sun, 23 Aug 2026 12:43:14 -0400
From: Gregory Price <gourry@gourry.net>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Groves <john@jagalactic.com>, John Groves <John@groves.net>, 
	Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <djbw@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, Jake Edge <jake@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Namjae Jeon <linkinjeon@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ira Weiny <iweiny@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Haren Myneni <haren@linux.ibm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>, 
	Jiri Slaby <jirislaby@kernel.org>, Ethan Nelson-Moore <enelsonmoore@gmail.com>, 
	Gabriel Whigham <gabewhigham@gmail.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>, "venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "fuse-devel@lists.linux.dev" <fuse-devel@lists.linux.dev>
Subject: Re: [PATCH v13 10/12] famfs: Add runtime operation-permission (opts)
 framework
Message-ID: <aosejKmNJxCIpQho@gourry-fedora-PF4VCD3F>
References: <0100019fed5850ec-2bdfb17a-3086-44ea-8fdd-777d3ce12a33-000000@email.amazonses.com>
 <20260810202539.96378-1-john@jagalactic.com>
 <0100019fed5a5210-a09f1bdb-c705-44fc-8108-a7e7995a7af0-000000@email.amazonses.com>
 <20260822000728.GB6047@frogsfrogsfrogs>
 <aokdSo9li0RtEt35@gourry-fedora-PF4VCD3F>
 <20260822174029.GC6110@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822174029.GC6110@frogsfrogsfrogs>

On Sat, Aug 22, 2026 at 10:40:29AM -0700, Darrick J. Wong wrote:
> 
> A bigger question I just thought of is sharing cxlmem between files (aka
> reflink).  Is that allowed?  I could see a theoretical usecase for
> programs A and B wanting to share some cxlmem for communication or
> heartbeats whilst having their own /a and /b files for their private
> memory.  Probably you'd just create a /common file to do that and not
> map the same cxlmem page into /a and /b, right?
> 

If the underlying memory hardware is hardware-coherent, then this would
be supportable because the coherence domains of all the hosts connected
to the large pool would extend to one another.

In our current world, these huge-memory distributed memory systems are
non-coherent and each host's coherence domain stops more or less at the
head it uses to connect to the shared media (it's probably more accurate
to say it's "device dependant" but that's besides the point).

Anyway, there's "allowed" and "useful".  You could technically do it
(maybe not with FAMFS' current guard rails) - but it would be useless
unless Process A and Process B were in the same coherence domain.

~Gregory
