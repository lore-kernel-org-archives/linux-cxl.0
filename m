Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792515052;
	b=RDCfrJxVO+4lGJhcGM1ewt8x6bxN+b4kKWUiRYwYSVCYfkVSUS7kuW0AsMhnS/d6zXbm
	 Wp2PRHkAuTHM7/xrWR00iJOMye6DLXnxBa2BIGpvQ+RCic8CBc9nBkH3me4rDxiORaUff
	 RMYuVpsBimwHnhX8ySqajqIrdGheBluv2qHuXoe3CCq+0qVbB84waCeaZ8ZDx9UyyqOKf
	 GbJz4U7+9e+OA6UbA4A/coeWzi7D5XjyEMxqhMi/rw/PznUYvStUzCM73+5z1iXZAx+pA
	 WGG2lVd4yX0MGGaMxkpZhuXzmISoj8t7xBjx7x+UWlcQ/1ufvoxk5Ut5NtlmD3JvMfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792515052;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Rspamd-Server:X-Rspamd-Queue-Id:X-Stat-Signature:X-Spam-Status:
	 X-Session-Marker:X-Session-ID:X-HE-Tag:X-HE-Meta;
	bh=PnmvAioouzOwQoC09Cdmt1tpBbxHXn0G8J4x1674Zv4=;
	b=k2xG+NW4mePaYPBlMvnfZaiLo7WNsjSs0PNUZYykqafd3Uo+Ay2qU1bWF7a5XbuLoxGR
	 USBihVTDIJPhrMKBdgLbey7T+qzJzacJwxo39wPA+bRE7TXPHT5zGL4DpvviRe4YqzdC9
	 FS8sUWeCl0T/Sqy/baPpyD9p79p1BDgOIhaI4eSLhw5G6okDZePkkZ4mpWCTLwuGSrj7f
	 MBwl3QJWyHhVI1LRAYtRKHO4X37+NJBfqC2gIu7QD3n1p/lfIO5Q2f9vFS5NeTV0K/9OG
	 Z60pLBT1Nvx9Os7Asa3EUkYWV1Q18B9UpR67STAd96Vuzooav2Imk547ZYUOf0MQqpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=groves.net;
	spf=pass smtp.mailfrom=groves.net;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3004160A262F
	for <linux-cxl@vger.kernel.org>; Tue, 20 Oct 2026 16:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3004160A262F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=groves.net
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 48BCD80110;
	Tue, 20 Oct 2026 16:50:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: john@groves.net) by omf07.hostedemail.com (Postfix) with ESMTPA id 027852002C;
	Tue, 20 Oct 2026 16:50:46 +0000 (UTC)
Date: Tue, 20 Oct 2026 11:50:45 -0500
From: John Groves <john@groves.net>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: fuse-devel@lists.linux.dev, Amir Goldstein <amir73il@gmail.com>, 
	"Darrick J . Wong" <djwong@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 00/10] fuse: DAX device based extent maps (famfs)
Message-ID: <atebTqE6E7qrEmqI@groves.net>
References: <20261016151638.2962413-1-mszeredi@redhat.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016151638.2962413-1-mszeredi@redhat.com>
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 027852002C
X-Stat-Signature: ryu1ic3iufidkbatut4ng4go3zkhny4h
X-Session-Marker: 6A6F686E4067726F7665732E6E6574
X-Session-ID: U2FsdGVkX19iLIuEpncD+kVsCkM1rZtglGsU8PhfIBc=
X-HE-Tag: 1792515046-62564
X-HE-Meta: U2FsdGVkX1/zQocfxwA9/b8bi2d+5RkHAHVE6Os6e2LjiNkInITgGXoZEe/6J2a6vqfWw4TbOlVsAfSLvfQmZXXzVrfgX2Qcbh0EvVXlLdVh0/2FE9MyWzx7J2o1UBrAeEvsHQWVAvZ9uQLHmGQzjDDhFrU+eT5NrNTb9ecro8um6vfr7f6wkKt2xbuE030FDcCRJ+G7n3LsxYOgqJmC87G3Ow5xo8q1RzFvcTkI0yFzX0V67CYHf3r3poexxE7o5eW8p7N4Q5xrEpfSGAwQ4q1U2S6sk561wiw9rAGczxocB+OhyaZmMDk5wl+RWzN4/ikjwePSGssdf0gj+bBlFP9ToYTNwhqL1lptx07tY3qskVDQEjq+yxbF1aZSUSBxKAjx4LEfrXs8AwDV9R1sFTQp8aIODveQe+nS4F1kckw=

On 26/10/16 05:16PM, Miklos Szeredi wrote:
> This is the FUSIfication of the famfs-fuse patchset.
> 
>  - extent maps are assigned to a backing ID
> 
>  - 64 bit backing ID's managed by server
> 
>  - maps can be linear or cyclic (striped)
> 
>  - API supports nesting, but not implemented yet (i.e. multiple striped
>    extents per inode, a-la famfs)
> 
> libfuse/famfs trees for testing:
> 
>  https://github.com/szmi/libfuse.git#extent-map-v3
>  https://github.com/jagalactic/famfs.git#master
> 
> This patchset:
> 
>  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#for-next
> 
> Passes famfs smoke test on emulated dax device.
> 
> Comments are welcome.
> 
> Thanks,
> Miklos
> 
> ---
> Changes since v4:
> 
>  - extent array (John)
>  - error out on truncate/hole punch on a dax backed file (Sashiko)
>  - small fix (Sashiko)
> 
> Changes since v3:
> 
>  - redid the first patch (prompted by sashiko: passing dev_t is racy)
>  - more fixes (John, Amir Sashiko)
> 
> Changes since v2:
> 
>  - add a trivial prep patch modifying drivers/dax/super.c
>  - reserve zero value for 64 bit backing ID (Amir)
>  - add Originally-by: tag to acknowledge John's work
>  - more fixes and cleanups (Amir, Sashiko)
> 
> Changes since v1:
> 
>  - moved 3 prep patches to fuse.git#for-next
>  - introduce FUSE_PASSTHROUGH_V2 (Amir)
>  - lots of small fixes and cleanups (Amir, Sashiko)
> 
> ---
> John Groves (2):
>   dax: add fsdev_dax_from_file()
>   fuse: resolve extent maps in O(1) when possible
> 
> Miklos Szeredi (8):
>   dax: use READ_ONCE() in dax_holder()
>   fuse: add helpers for EIO return value with kernel message
>   fuse: support 64 bit, server allocated backing ID
>   fuse: support opening 64 bit backing ID
>   fuse: add support for opening dax device as backing
>   fuse: add extent map data structure
>   fuse: add extent map I/O support
>   fuse: add support for striped backing
> 
>  drivers/dax/fsdev.c       |  23 +++
>  drivers/dax/super.c       |   5 +-
>  fs/file.c                 |   1 +
>  fs/fuse/Makefile          |   2 +-
>  fs/fuse/backing.c         | 302 ++++++++++++++++++++++++------
>  fs/fuse/dev.c             |  54 ++++--
>  fs/fuse/dev.h             |   3 +
>  fs/fuse/dir.c             |   6 +-
>  fs/fuse/ext_map.c         | 376 ++++++++++++++++++++++++++++++++++++++
>  fs/fuse/file.c            |  33 +++-
>  fs/fuse/fuse_i.h          |  79 +++++++-
>  fs/fuse/inode.c           |  25 ++-
>  fs/fuse/iomode.c          | 116 ++++++------
>  fs/fuse/notify.c          |  75 ++++++++
>  fs/fuse/passthrough.c     |  66 +++----
>  include/linux/dax.h       |   3 +-
>  include/uapi/linux/fuse.h |  53 +++++-
>  17 files changed, 1044 insertions(+), 178 deletions(-)
>  create mode 100644 fs/fuse/ext_map.c
> 
> -- 
> 2.54.0
> 

For the series:

Reviewed-by: John Groves <john@groves.net>
Tested-by: John Groves <john@groves.net>


