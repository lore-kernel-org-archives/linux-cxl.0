Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AF43932DA
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733865; cv=pass; b=coBrRLYBStLG1pdXIDXhlxS4pW2KCXSY4OYdWItWx8NNTsV3yvTTYgIkYLdBfIZUcmy3RavqFLFhgv5wfsIlBcu+7h9G3TV6iP464XITjezQUzFEbDOrM0ZdwMCoxEL4V7Okx3sjFg3ajQuqCASMcIIBVdhAD/fBEMtZ/fzL1UA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733865; c=relaxed/simple;
	bh=FmqQi9tHDOGtMRA8eYccGrCqdDwhdIqG1ghsXPY1Uts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YdKoGt7Fv/bzpXFIGQFYghS45GWYvQhzP9aVgS1HAImxWZPshLhRqUfvRewWknkSEqbKE9l8o7t71RNVqr21GuMni/2UfyyRjW9Lu1B+K8rpbge61UTaXg5fjEC/gzIqeWnYiqAt65y8ETdsqtNX29Em2uKI+REeIYmorVoD/SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=id3l4Dsm; arc=pass smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="id3l4Dsm"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e5c92c389so867524485a.3
        for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 08:24:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784733856; cv=none;
        d=google.com; s=arc-20260327;
        b=SYfOjovTWrdyK58bWjzP6EQ6HhZoHV11cI4f0fE3zJAAEflm77BqBGJ4bNRt8qXtg8
         g5DcDl2O2VX2BCPGJmVmQ6x/0Zx+giKcKEAGSigIWXqFxO8OqgwfsO+B+fG/njkev6Pu
         cqyP3ZKTZuKO3YsZfmKzp0l3jm0KEUG5LVkcRwwPV7XNZSauMWOtT/ve5ct1BH/Jkp2U
         cOv/FhTcSm4y2vphhhiqqnS4VyMm53rGu3TbZCjuj89UNrjuhJB4FpwmBUoqjTwI6DuY
         wr7+8loD+YnyAbggHbkxxjGdcEMFochIKkr5luGBOU9aZrHtnlhEhGig5vFCSaQRNSi1
         vrtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ff8+sJsygEDuStaVFp2hCNrsI9M5jePRaYSdvrv4X0o=;
        fh=vKseME5oQbAgbTvZhy/mhP3tYLUtWbJ43YFPVPuB/N0=;
        b=c84WMXbsGml0E0woIP8dnh0000vxIuaNz05CLH43wrjcDyHJD2MUe9G2Kuia8zi49V
         JK68ZTXGFk22ydanWlcKCDMvzwm/OfdaDpIc6DLypiEe/mpfrKJn4FhlzKNJp8RqznnU
         iAxVBZZPvzti4URn7+zurTGD3dGl5pYs3fDdfwNUhwjNX+qRUh38S+JA2Bp+hNhDnKrs
         fzPcyEbVjAVl2ZHtqYaiBpjoXQYg345qT6J3WHKbgDowN4rjZX5bEkVFbhIYDLFck8vb
         ftncb85H2r96nZCiS0WJEZWB9x99KilezGXwPD8IzC88c+UaN5Xb0sFEDGQvP057kiD8
         TQMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1784733856; x=1785338656; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ff8+sJsygEDuStaVFp2hCNrsI9M5jePRaYSdvrv4X0o=;
        b=id3l4DsmZgREBbR6h/yxiO8eKv7LGI8EgxPiuuBbKGEHhiFxQwAxjladnBswED/Qmw
         Ax33XN2mHBzIUzHztECMTaNs72eqwSZtXmZaaifQAOiIk1JvMm4VNBEOaCCSeomIAJO0
         bmRifZH5PIDCqagNJN3TFMKqmosgxKwkzoa5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784733856; x=1785338656;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ff8+sJsygEDuStaVFp2hCNrsI9M5jePRaYSdvrv4X0o=;
        b=o+NC1NzKEsiEOfFJBnKTnfqSqNuY2VvFq71DcZX/EOX4k2xFaqzcnw4QTQflitpEKj
         iqItdWV5bWoSPW9sX8slZFSsYw64Me6kVUEQoFpy1Ln59tkAtOzp1Ul0sQk1QoHxF23n
         UfYyFunLSIkYewryKqQc3F17uI9r8OINv5Zpfn+F6edFEwiqvCziYaoQNnEeJQ3OIFy2
         hovlQJRvpS48IJeXaTqPt6Zg+RJ2M/pl0gr9EPO8Xfp38VqZd8pqd+BAX0AW4UbUBPpP
         0o/bEplDl0Tfkd+T5Yem6ED2EnuXM4LvQ9zZUFlUcwwUB8wZiEopTgXJaOlzQjlIGumG
         ZIKQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq9DpeYml4S3PI3p+0cN2otP93kJW6NJNbaVOsi65KV97mMBx6Sfd7dU6/xBVbzXT2vtWcuodyEywg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDxLPRNjPJVma/DsbOvrdGy6T3gFRoc0qr4vKyhrsCZw197J8l
	AxLb6JR5IolskWr4NKBWGuXYANfVqH0VBZZolZc5vqhbvJlKzp/dGQ6f39ITxJVpJhwNwjXXMT6
	+A1Dmy/dIIxwqsFV2L5bQWVrBmyxCejygjkHpIZts4A==
X-Gm-Gg: AR+sD11m7PpqXfuiDsWjMmVxRROj5KrO9ctNmG736vYA+GcI+9Feha+rxaaaVw+OrH0
	y39bKHQgCx8VTVYQaHEDf9wXw7ruc8mmYicWiaszFCOZp5ypXSeJfSUKenl/uvvn8fUhcAKuzlf
	YqWwRCbSkhLkehIiSiH3sow7iDLdTBQawG1zhZZRwQpirblP0tpCemrp8I124Vyh1caJ3LmE6eC
	1jFM8jyjbu20K3yWJVqnqYHOvMA6nfyztlU0DrMQEz9opaZn8zq37pi6VZ4sTJgPYthPRXufr+v
	DhdcYYegTa80RvkTqA==
X-Received: by 2002:a05:620a:2844:b0:92e:9cb3:3f71 with SMTP id
 af79cd13be357-930b3ed66f6mr2281752885a.36.1784733856139; Wed, 22 Jul 2026
 08:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720034553.68798-1-john@jagalactic.com> <0100019f7d9fbe81-6cb16662-2522-47ea-a152-fab0ee3d9b35-000000@email.amazonses.com>
 <0100019f7da174eb-4cd0f3ae-59da-4533-b469-6eee009a22bd-000000@email.amazonses.com>
In-Reply-To: <0100019f7da174eb-4cd0f3ae-59da-4533-b469-6eee009a22bd-000000@email.amazonses.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 Jul 2026 17:24:05 +0200
X-Gm-Features: AUfX_mxUSuw0ZWzZWiq2Rpl7efuyYxiFK3IBC4AQjtyaBV6Cq7Rj41foWBlGbSE
Message-ID: <CAJfpegvkbK4xtQsssn3yrdLn7zZRGB8MeRcauP8mbmJRCnFouw@mail.gmail.com>
Subject: Re: [PATCH V11 4/9] famfs_fuse: Create files with famfs fmaps
To: John Groves <john@jagalactic.com>
Cc: John Groves <John@groves.net>, Dan Williams <djbw@kernel.org>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Chen Linxuan <chenlinxuan@uniontech.com>, James Morse <james.morse@arm.com>, 
	Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"fuse-devel@lists.linux.dev" <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Jul 2026 at 05:46, John Groves <john@jagalactic.com> wrote:

> +/* Famfs fmap message components */
> +
> +#define FAMFS_FMAP_VERSION 1

Please don't use separate versioning for extents.  It doesn't help
with feature negotiation, so let's just use the INIT feature flags for
this purpose.

> +
> +#define FAMFS_FMAP_MAX 32768 /* Largest supported fmap message */

Not sure if it makes sense declaring this on the user API.

> +
> +enum fuse_famfs_file_type {
> +       FUSE_FAMFS_FILE_REG,
> +       FUSE_FAMFS_FILE_SUPERBLOCK,
> +       FUSE_FAMFS_FILE_LOG,
> +};

Unused, apparently.

> +
> +enum famfs_ext_type {
> +       FUSE_FAMFS_EXT_SIMPLE = 0,
> +};

An enum with a single value is not useful.

> +
> +struct fuse_famfs_simple_ext {

struct fuse_extent {

> +       uint32_t se_devindex;

uint64_t backing_id.

> +       uint32_t reserved;
> +       uint64_t se_offset;
> +       uint64_t se_len;

Please  drop the "se_" prefix.

Please add more spare space here (e.g. uint64_t space[3]).

> +};

> +
> +struct fuse_famfs_fmap_header {

struct fuse_extents_header {

> +       uint8_t file_type; /* enum fuse_famfs_file_type */

Unused

> +       uint8_t reserved;
> +       uint16_t fmap_version;

Don't use, plese.

> +       uint32_t ext_type; /* enum famfs_ext_type */

Unused.

> +       uint32_t nextents;

Okay.

> +       uint32_t fmap_size; /* Inclusive of this header */

That's the same as outh.len.

> +       uint64_t file_size;

Same as i_size

Thanks,
Miklos
