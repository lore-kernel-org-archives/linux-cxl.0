Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B115137750
	for <linux-cxl@vger.kernel.org>; Sat, 22 Aug 2026 04:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787372344; cv=none; b=Se3iraAcqGwCy8e9kdDyNe5rHOfM8TAPXNSW2g1GI8RrxCyIZQbg1FskXRMDOh+7NdF6CTwro+gUeD560Y/ClvlZYFBv0f528AEw94ZuHGQ27a5rGJLVIlXIGB6AEkMf+X8xargDwAHTX128AWMRoQazymxRL32w/8OYONi0GlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787372344; c=relaxed/simple;
	bh=/Q12GR875iD93KhzcjUTpLysJ1kI3/4TfP0uOO6zmB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imK3h4t3K7uydUSJ3F2jOLiaexWAK3npjk9u+Co/X8ZTHlVYNdcll2Y8fTxMXRz1PgEoyJunhHcktAK6lSeIVZ7H2SnJfx2Af7t2UD6M8RlJRfhc0zlbNt5SposOvNH3eUR/WlTqndKChjiGFa3mtzMUZHNiL8qZ3g9ILL2/g54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=THhyu0up; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="THhyu0up"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-52b6543169fso11693461cf.2
        for <linux-cxl@vger.kernel.org>; Fri, 21 Aug 2026 21:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1787372342; x=1787977142; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bV2EmVqYabp31e4KZo4BjvE2tm+i0eWvAIeJunRO/yE=;
        b=THhyu0up9pDDkhcf62wTIZYViQLq/cJwTfNR2ZMcY7vgtfRIu0XTTrTnctZ2Rkyl5z
         OTCGrPlYMvBVlgd27wCbOfsiQF2xOwHJkiz16KTcjLKpNqOLH0jPsXu9zbsy3X2syX9B
         oz5WCbMoLt5+smI92QbGiUGV1+hyE3IkFB+K+F+52HooS2VFJ0HAuQj/ah5rvSgnBkMQ
         ZhT+0CYXJ1pOXUYziIujTNFjqboyrtBIdB4LV+r8k/obUy6PcrBYBj3UH2sPm8ucfkoM
         2zRV8CVUPYQvHB086yPizUecls8pHdti4Zss+CM7XoF42UJXDT6AXrhCRQIDQPfNVYQG
         V9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787372342; x=1787977142;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bV2EmVqYabp31e4KZo4BjvE2tm+i0eWvAIeJunRO/yE=;
        b=ilCyyOKYnwA01aNQPIIVZdPGlMbdjNIPBgRn/x5HpR4xASGWcQId/sUCk7vxG8faE8
         k6fFoxfG51HzGbfKauGD4eNFxEL1HaP4ScvWfwmtkqkRtJaB2tnpzBPlAspZUxnIAJ39
         5enGWd52/Ojvdyl6Y398D7K0lwpO38jl2mHl2nvpSCNOize03WVAr46rLKFqCpOEQKMb
         CbUmn/RIHgSnOer343TidLESRN4E1VvMj0cwGni1Yn9iiE5gTBeZx7B99GplYtNlGWeG
         Fha5T5SLD/Q9XbEQEAeJVPcz0Pp2f6bjRQMcQaYBGpxSdfIF1EmVFY67iDcvrU5OT25o
         RaiA==
X-Forwarded-Encrypted: i=1; AHgh+RosBDcU5fowm8g5uCHtMJKUa4KvHnGQbsQNKT8VdFIqNCkNwEpIcrbSBnxNnyDyMT65E6+oxmhvBi8=@vger.kernel.org
X-Gm-Message-State: AFuF++kWeOMmG5XH0dvH/OlqsaayZH06Qetm1VsyRu1+Me1FfKDNhlth
	emsIQdVUpbIvlUTSQ7k69BXJZqn12Z7DolQBYENPRCZTmVql4y0WDVXRAoUuASI+tng=
X-Gm-Gg: AR+sD11lE6RWsuFVT0f5XKkwLq+D4BwCHOE8iu4PhuBb4B/iL3xnPUX0ZiLG/FeDXIC
	HHwS4WH4ChFrZRc2eGhPFZRP/RhtotbhDTfBDODxv/naYxuWFVDrPNqGCl8S1D21OgIlWzHniUf
	c09wUDD7XzJu7JXx05IEUPnW2k1I3r1CxK8fMH1ifw5FScToz+dpwbpkDJgIvktJjfh38jfhczD
	/TxA8yUjA8sK9pPtv+ZHGpoaSuOuGkv8FpfueiBomOQKHfEEwkrTtPrsK4Sd0czFTuwLbR9bkmr
	MJnHI1VDtn2FQsxyCXuh+ldsxL94+vQhrdKYZwx8C7AflmIiwJ2KdoSydNwIOzIpm41HOVGpNzH
	X1Pk6UTE1MBpuZKggoXxJN5uKZJHNZMGiIccvQg3xqU4NVxf7AWLZWUXJhPM+vihwjFAGqHA/18
	p8MvLNCMtKGezEtbWplUeaNVmsZGUV42Pz1/xEG6n73AJpDf579+g1KCcf6k0U1zux57FmrU0cS
	OrnhoKDz1/Y8DlGQXkm5WfrBj9jkzgPRBnOIWIMzKdG
X-Received: by 2002:a05:622a:17c5:b0:52d:a247:bf5f with SMTP id d75a77b69052e-52df5a54f6dmr101297051cf.33.1787372341767;
        Fri, 21 Aug 2026 21:19:01 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c939314d2sm4857616d6.25.2026.08.21.21.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 21:19:01 -0700 (PDT)
Date: Sat, 22 Aug 2026 00:18:58 -0400
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
Message-ID: <aokdSo9li0RtEt35@gourry-fedora-PF4VCD3F>
References: <0100019fed5850ec-2bdfb17a-3086-44ea-8fdd-777d3ce12a33-000000@email.amazonses.com>
 <20260810202539.96378-1-john@jagalactic.com>
 <0100019fed5a5210-a09f1bdb-c705-44fc-8108-a7e7995a7af0-000000@email.amazonses.com>
 <20260822000728.GB6047@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822000728.GB6047@frogsfrogsfrogs>

On Fri, Aug 21, 2026 at 05:07:28PM -0700, Darrick J. Wong wrote:
> 
> But what prevents a malicious program that is /not/ the famfs client
> software but has CAP_SYS_ADMIN from doing that?
> 

Such a program can already unmount famfs, rebind the device to
device_dax, and mmap the whole range directly. MAP_CREATE isn't
handing it reach it didn't have.

~Gregory
