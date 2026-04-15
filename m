Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3EA3DE45C
	for <linux-cxl@vger.kernel.org>; Wed, 15 Apr 2026 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776267182; cv=none; b=CZppuj7aZCuzmKOnav1nAAHNqJ2nChHRimCRIHx4/f4AI2J/EP1iVz+9+gsZ1sZm686kBYixwtiUB3ZmOJpGfXzGS15gcnfXmco5KzDp2Y0e3582kvKJZD/VtkE5TMG4Ov+5Q/BJFskQAJxadn21q06ssKocI5Je0TP1DZRrRi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776267182; c=relaxed/simple;
	bh=S9dcy47a6bd3TjyPD9yCkf196y5TA2ypeoVg+NZ5el8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWIex/ZvacEf8SeGiZY2u+ZlBZnPsr9GZYgd5cpILz59V6/+yB5g6nRaLI92n1pqyB2d5em0gmO741BvnXAgzwodbB0RcTlje1djq4iezoiPhlcaJztAkrKu6QB701qE4LRL5YX/VfKAa0oEa7YYEaGSbUjsZqJdbpJKVvvaoJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=F75dbddm; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="F75dbddm"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64eaf8aa893so5915405d50.3
        for <linux-cxl@vger.kernel.org>; Wed, 15 Apr 2026 08:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1776267172; x=1776871972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e5e7YwNWCtbTE/x5+I5oKOHLYRavpYy019TGcszzWak=;
        b=F75dbddmtN8OwVFOGaZDhKK+Hwp3WWuk6vEYx4MlQTcEs+tFqsdTq57ybk+HLuWF8C
         C6OwnvIApNdSIYMiehBPnT/3ZTurGwkLIlxJk5YEIH/y+CwjQosV+dZxCz34E3TusL6E
         ERtST/ZlnXo/FJuJl5pSsxQ9GTH7qD3pCxch5xREEZmaNYLAdzuNYZ4dlbYGwsW/z2my
         nxVyyA+LsvpSaiR+V237jdWKTs1RO2UQhEbpfvOjBVm0pyDcqOsQl2mp+0zzHKVH+itc
         ONzHa2xlsJiGmYeqHns8wheZq+qgV1xvolB4hGFbwGTmRtLNIMGjrGFyvOQP5Oi+vMRY
         laZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776267172; x=1776871972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5e7YwNWCtbTE/x5+I5oKOHLYRavpYy019TGcszzWak=;
        b=b8/YWpXMkLsiB3deYXK6vLmJCMrW1ex8foKnGbaqI+k/MxgEll8Yd/gAOR0xOi7m1O
         krGEfjjfebX0XtqXhw0DBSx42FzlcYh5UFcoE/2e1toa0r5N0gcOt80dnD8yAlJXPsbN
         x2hxtG12MqPTipzAybXISX1FHKkRcmiaXgiixuEOow5uKbuqAy2mN5sUskdCRpKd14Oa
         G6+696feITUw5qkWpnlTyTVODtAqNL7/hyfc+CnwHwXPOREjMLLfyQ3czdB/dOS1BBRi
         X1IdMv8q7Y2o9rPcnFtyVUvNv49MTZpx0t9rEOSLSWG3k8SaDEGvU1GhTmU7YD7fomiW
         9wsg==
X-Forwarded-Encrypted: i=1; AFNElJ9gxeaFB1bDEHnKJTOjZzH88h/3iU9QJ3t7+d/5F2Amr8cFvS6WkY3udmhwwsRCjTUpwo0t0770j1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKP8YIimpyzh28n5drpnamo9JdD28obUxcu2fS7v0lQL3YF1A7
	Sj06UJcKzJKwmKQVHRJ6ip9zxgq53dlf8f1hese04/8qMUGeIMUvoa9SSAnVa1Ht2sQ=
X-Gm-Gg: AeBDieutNwBuupWCPAuO/p93RzHS4WMXiiuXoDV7FjivBFDpYhubB5ufUK9rsZLhzjH
	ye4vSM6JJwZAGKOqExjpB9+1+dBk5ER50SpkcmAGY5f2+SIGRVadGuYL1Gj8c5uYUmzmWO2izBa
	p0mQOwkVZYhX+bGlzqvSQ7l9kzhSmpCHrPDtU4t50J5qcAwjDbE5RQhDu8I1bGFMI5fPw31EFEX
	pcmAJCGur8LLjA+qNAl80xa4lXQXj8EvnZaDr27KFiLpfterJbeyIsmHv3TVLVJ1n2TD/fWWcOQ
	8N+wxsE8D7ljeJ0QIJ9sxGW2KdVUgreZ720fi1yfks4LPUIz/8f7IjehkF8Q/f53TNDC+aN1fpC
	1VRH+Nd0mO2udv/ZEdtZhvcE2PpfjJhHhQRgctuGP4NkmY7+pqlkFMR9xBb5J0D45rErbCh9VEP
	fLy1dLphs6Cy6X3zhhrRwhhFJqKR/6q9MlBQjwRMzvELq/Hcpy
X-Received: by 2002:a05:690e:4188:b0:651:c024:5726 with SMTP id 956f58d0204a3-651c0245898mr12329101d50.33.1776267171618;
        Wed, 15 Apr 2026 08:32:51 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2607:fb90:ea03:4042:f7e3:e9e9:9e22:5a8e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6cb9ea1csm16952326d6.28.2026.04.15.08.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 08:32:50 -0700 (PDT)
Date: Wed, 15 Apr 2026 11:32:46 -0400
From: Gregory Price <gourry@gourry.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	John Groves <John@groves.net>,
	Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	John Groves <john@jagalactic.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	"venkataravis@micron.com" <venkataravis@micron.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	djbw@kernel.org
Subject: Re: [PATCH V10 00/10] famfs: port into fuse
Message-ID: <ad-vnqRrUGs9n0N8@gourry-fedora-PF4VCD3F>
References: <adlBcwJjLOQDAR65@groves.net>
 <CAJnrk1a06zkUmXW5EFiUmgAoFauwtzsYvnotaPH0ifVtyh7iDQ@mail.gmail.com>
 <CAJfpegvVTcV89=q3L326aGQjhduBcv7PVg5QKftGLjNZmCLmaw@mail.gmail.com>
 <ad4_jFsR951c2Mtn@groves.net>
 <20260414185740.GA604658@frogsfrogsfrogs>
 <ad69tTnx5YkD4Y9K@gourry-fedora-PF4VCD3F>
 <f254f6fc-dc06-4612-82d7-35bb10dbd32e@kernel.org>
 <ad-UAMcALRubBcHk@gourry-fedora-PF4VCD3F>
 <CAJfpegsUVv0ziMSQiq9pKeXf6G-+LROPTW077hHMSmAirVCLQw@mail.gmail.com>
 <ad-qSB4oL5D3S-ht@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad-qSB4oL5D3S-ht@casper.infradead.org>

On Wed, Apr 15, 2026 at 04:10:00PM +0100, Matthew Wilcox wrote:
> On Wed, Apr 15, 2026 at 04:04:50PM +0200, Miklos Szeredi wrote:
> > On Wed, 15 Apr 2026 at 15:35, Gregory Price <gourry@gourry.net> wrote:
> > 
> > > This was my first reaction when I realized the BPF program would be
> > > controlling iomap return value in the fault path.  Big ol' (!)  popped
> > > up over my head.
> > 
> > I'm wondering which part of this triggers the big (!).
> > 
> > BPF program being run in the fault path?
> > 
> > Or that the return value from the BPF function is used as iomap?
> > 
> > Or something else?
> 
> If a BPF program controls what memory address a fault now allows access
> to, who validates that this is a memory address within the purview of
> the BPF program, and not, say, the address of the kernel page tables?
> 
> (I have done no looking to determine if this is already considered)

From an initial look at the existing bpf ops structures, I do not see
any other struct with a similar (obvious) pattern - so it's not clear to
me such a concern has been exposed elsewhere or directly addressed.

There is a verifier step for the BPF program that in theory would
validate the range matches the DAX ranges, but i think that only
validates the types are right and only on load - I think the BPF
program itself would be the address validater, which is a strong no.

BPF folks please correct me if i'm off base here.

My initial take is that it's a real concern a "bug" in a BPF program
could let userland map arbitrary memory into userland page tables, and
such an extension would not be a quick fix to the FAMFS problem.

~Gregory
