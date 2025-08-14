Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84373002AB
	for <linux-cxl@vger.kernel.org>; Thu, 14 Aug 2025 13:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178601; cv=none; b=GRbEkLf/DXQlaQSzRIwunmWnum0N4Q8DwPLjth0VhmpcMQDd0jH6FahRhrcZlZXnR0MRpnSrS9RJzQpHNoyHHHEPn8iCd48t0SDzdTw2+6aHAKdXJcSvLWM+HvgJLZG6uEi1fw5hj7fz5TMauvVziAOrETBwQw52PGgDPjNPzyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178601; c=relaxed/simple;
	bh=5pu5CCcwVsrYR5S/WgA6wkxRR40hQbEFvk1WFQLNauI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A4HpgLQtDuGlqcUZ8gr3xYOA7PoTXNHR+4AkCLaU8j2Gscm5A54CkzdjqERlKM7hIm0CzL656sp3tl+RPddZZvxxxzBUOXXIPgAgLgAA+/dwseSWiAH7hgz00T/Mfg44lyBlRYNmfn4jLtRtz8hXIAKjiInV5UcTmG377utIMd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=SBjsbhDy; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="SBjsbhDy"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b109914034so9464181cf.0
        for <linux-cxl@vger.kernel.org>; Thu, 14 Aug 2025 06:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755178599; x=1755783399; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xiJ+voUm58mOt9ANl6l8BPcmKr+2Gr+D+s+NWbUh7rs=;
        b=SBjsbhDy5LLiWWwzXacdGJQ4Hp/Zf7tp9IRatLTbuO9IWQRQ0hpsacd64hUsDJ/pRx
         m329H7MHaTDl8QgecfN0tW1BXuAtJaL1kgj77NNERPrd5uIwqAFp3DNhVmFir3WDPnGy
         81q1DeQwetE3l+O+0dGR5KayoTZjdCCnzE6m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178599; x=1755783399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xiJ+voUm58mOt9ANl6l8BPcmKr+2Gr+D+s+NWbUh7rs=;
        b=bW3KMbNFUOFQzDzd+axSULmS8KGSlsGpasBFr8IxmqI3c2YLoW0KpARN/GyfXRhjH3
         k0qpkOhnI2T5II+JOzkIa7GegnmZyMCNiQZ/k2vC1ZMXxoa0LH7V3YsreRM4Jbma/emP
         0vtsxFhT7RY7et1MbbcEjgZNJNaMurGwePIQSgvt0t1/ukifzMzNOkvMCzRocFcAWjB3
         D9UOCUaEGLzEAC7V0bCAxp2M3BBeah3PD4MMgRIOY/QXT8MXDYSybe+8IXTCdF7onEet
         rLQQ8LuglpJXfS6G/bXCC4v3l059VxrTwdv6StD/5clM1U7kjSoZGJocvGj9SEL9a8I5
         9pTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAXx5jh3Gku89Vd2obJzgQLDHKQizPFKd0/1TJsYtFqm8oAxOiMB7+fLdJWvCUvtZhy2q3dW6g5kM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAAUh1S+U1N3VieRgE+IE2a1O2d1RTIl8x7ixCR18GLXyt39RC
	84ntjQ4+Ui5UcI6zCoMbqHQOcu8nIrYrHDniWbkTGejEx06Q4/pFLzZXKNPhx4OezoJyIU0bOo8
	RkZpia/s5Gg+bBoL7d5hGUYW/xWuTbtKQeuM7iQwAfQ==
X-Gm-Gg: ASbGncvCg3Y9UHmXNbUStDFlS55v5j9MhksAsahfrgn6kI/Y1zv4rYDAYqnUA9FTpIj
	KzxZ6nv7ZK0u80vRg+/yb+lwi0faNn+NlDv27bp0wEljB72fru4CI8wxInepz11mbogNr5lQ3YX
	lwGsQTavcp+wYimALEB5gC4Xl6eREgaRT48zvEm+1935iG8gpzA2kKqVJnUe2/HYTdpPyUHBw9p
	K90
X-Google-Smtp-Source: AGHT+IGRLUNSdSZic/AfvkGEhcJ0i0UexRhcMwBfu+hTgWYJPH7NmUnalP/saR/GroY1O9C7uFRCx1HrQwBXZpKp4dE=
X-Received: by 2002:ac8:590b:0:b0:4b0:7e22:36bd with SMTP id
 d75a77b69052e-4b10a97a743mr43862441cf.23.1755178598536; Thu, 14 Aug 2025
 06:36:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703185032.46568-1-john@groves.net> <20250703185032.46568-13-john@groves.net>
In-Reply-To: <20250703185032.46568-13-john@groves.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Aug 2025 15:36:26 +0200
X-Gm-Features: Ac12FXz5KYhharzGRoAiyFuPvtQSxT3MxOHi7MhrKR_P4gCMelGIrgjr1IHTKO4
Message-ID: <CAJfpegv6wHOniQE6dgGymq4h1430oc2EyV3OQ2S9DqA20nZZUQ@mail.gmail.com>
Subject: Re: [RFC V2 12/18] famfs_fuse: Plumb the GET_FMAP message/response
To: John Groves <John@groves.net>
Cc: Dan Williams <dan.j.williams@intel.com>, Miklos Szeredi <miklos@szeredb.hu>, 
	Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Jul 2025 at 20:54, John Groves <John@groves.net> wrote:
>
> Upon completion of an OPEN, if we're in famfs-mode we do a GET_FMAP to
> retrieve and cache up the file-to-dax map in the kernel. If this
> succeeds, read/write/mmap are resolved direct-to-dax with no upcalls.

Nothing to do at this time unless you want a side project:  doing this
with compound requests would save a roundtrip (OPEN + GET_FMAP in one
go).

> GET_FMAP has a variable-size response payload, and the allocated size
> is sent in the in_args[0].size field. If the fmap would overflow the
> message, the fuse server sends a reply of size 'sizeof(uint32_t)' which
> specifies the size of the fmap message. Then the kernel can realloc a
> large enough buffer and try again.

There is a better way to do this: the allocation can happen when we
get the response.  Just need to add infrastructure to dev.c.

> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 6c384640c79b..dff5aa62543e 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -654,6 +654,10 @@ enum fuse_opcode {
>         FUSE_TMPFILE            = 51,
>         FUSE_STATX              = 52,
>
> +       /* Famfs / devdax opcodes */
> +       FUSE_GET_FMAP           = 53,
> +       FUSE_GET_DAXDEV         = 54,

Introduced too early.

> +
>         /* CUSE specific operations */
>         CUSE_INIT               = 4096,
>
> @@ -888,6 +892,16 @@ struct fuse_access_in {
>         uint32_t        padding;
>  };
>
> +struct fuse_get_fmap_in {
> +       uint32_t        size;
> +       uint32_t        padding;
> +};

As noted, passing size to server really makes no sense.  I'd just omit
fuse_get_fmap_in completely.

> +
> +struct fuse_get_fmap_out {
> +       uint32_t        size;
> +       uint32_t        padding;
> +};
> +
>  struct fuse_init_in {
>         uint32_t        major;
>         uint32_t        minor;
> @@ -1284,4 +1298,8 @@ struct fuse_uring_cmd_req {
>         uint8_t padding[6];
>  };
>
> +/* Famfs fmap message components */
> +
> +#define FAMFS_FMAP_MAX 32768 /* Largest supported fmap message */
> +

Hmm, Darrick's interface gets one extents at a time.   This one tries
to get the whole map in one go.

The single extent thing can be inefficient even for plain block fs, so
it would be nice to get multiple extents.  The whole map has an
artificial limit that currently may seem sufficient but down the line
could cause pain.

I'm still hoping some common ground would benefit both interfaces.
Just not sure what it should be.

Thanks,
Miklos
