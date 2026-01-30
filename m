Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C549B36654A
	for <linux-cxl@vger.kernel.org>; Fri, 30 Jan 2026 23:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769814815; cv=pass; b=JpGIGCz2F5HU2WreebXDNvooplogL6sLpLMXtNsdBISI33FW54XUirh7zrS+hkFixsawRjd+cEsmwaGTq0OGbUshXxqgetMuOLvrZIahRHqpf8HGPCfVOMlTfyICP8ZiZWOlLW0VyvAfVuXOllFu41jOrrycW6x4c6ObWBPgeEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769814815; c=relaxed/simple;
	bh=c34Quq+eQsW819C0KqCK2tzNAvjf7UPjPYiue9c5K38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gs9o0JKyaAoNJhuFn8h+hJzhlAJInRmVaB9OsRPyzu1RYaeWfxBhGXmXQRMzSf8z7tx5M2cvnhoxYkIOf3N7yzYe8GPYZlfwss4FAjZP7P6oVEl39hgs+ooHB8aThIl68R0MdvNC9/P+E2Yne5otYC1j0JiOAl/L/lj2e8H6aAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlKSw3ey; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlKSw3ey"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-894703956b8so43543116d6.1
        for <linux-cxl@vger.kernel.org>; Fri, 30 Jan 2026 15:13:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769814812; cv=none;
        d=google.com; s=arc-20240605;
        b=GVXF5tkkeXmYYbcpeZpq0wL4Y7QodC8wfK4c5dhYxfFZmkdoBD+2nwjZA9FdZM9p/K
         7FuW22+JmazX1k7dkQfToXKlxd1KNaBQpctXcgD8kcLRs6fkcOR3XAmwSd09lVYP1l9r
         zPcRuFmo/BE4grym5RFFNYijWlMljwKalc10IXYUcmkDqmsvHjtZZ1BzithDNgXbnbBa
         anUVx3NB2Y24Oh74n88F+ugtc50YvE/YDNUspM526QG8b3TIpKfw53t9APwD/H/Iebl4
         fOTFdrDlHxY+EDarvmcLtdPxZs09K+bqsXVAotnzNw7ZUht1T3zDAdn9XcaULpoIFzuS
         k9Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mCpt40N6zxEp6+nDSQMAaK5Vngq+apunb1ikLDPBcPI=;
        fh=Oczxse4lCfSZZaszX1SBPrjAKyfkvXJjfltIPVeckcE=;
        b=BBY63Ain6cWcA0akBWvpPPY9tG6GY/faFcw3RekaTIe5yA+dyumOjOgnt+5yu1mK3N
         1mJn1tKzE+atYSXlYijvWvDeK9iEt2Ymnd2ZPREtjZUbcnToCOJkCvdkkcnpwK/KyiSG
         NDyeHG21xoi1z/qT9ck12pEVGQNmVFA6GGDeapUOFYgKXHbh1uBmoVAV5fSzMXI0Y/RT
         hiFi8JeOhpU6/k3cipgnuZUVU/CaTw8FHXciXsDFhCm1H1O00Jk4k/OxOCL10qqFPvCw
         HOygT1qiFunQmvgnAqk9b+xRp854O9PNDhDHujWDeQ4qEfuxIcNu2Ee+DAuVQZbPx+b/
         xyKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769814812; x=1770419612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCpt40N6zxEp6+nDSQMAaK5Vngq+apunb1ikLDPBcPI=;
        b=NlKSw3eyc1tyXmspzsAwqjEg0L5qtn8VEtydTsA1k/t5kIJxOhrN2xKKdm8BWLN4zz
         rHri9/V/4RaC+06llGtYHBEbstcKr3C2GEYlv+T0zCAcKgW5DwWdrG4GOhekhIpSKNbz
         I4JR2O3IP1Dm1IvYTvX34MyT2FHLc1MS/K0DZp+HKPt3/k3BxZDOXv4U4ca6cPB7X49/
         DzaO0WmFUwSH/KlH3p1SVDNYEkd+OihCUPLw4RbFD24BnLOm47UrWhuqo9VaIefTFdlY
         AutTs27CmaoB8IgK8gsy4HdDweucvKjr0i0a7uD8fogWRB6mEthY6FbUf3gZJSknQ+dF
         rBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769814812; x=1770419612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mCpt40N6zxEp6+nDSQMAaK5Vngq+apunb1ikLDPBcPI=;
        b=d68pszezwqbhuizoLW+jCz8eKRr4479UI/kYzP770teITppUrEYPmB6w0Gxg7TjGE9
         GOXL+1yR9Wxu/xSQ1XiewnuRGNt42edNQsrF3wGKX/vlHAvWv1nyhYvG8CUEKH8K6VOK
         6Fsh61Lk6QrqTWzgeUiUeJ/YodEveuwYCwogkGE9h4PeR/Nhip0gu+NoEZPy3wfgFNzi
         X/sIeWSAM1aEjGkecviBTHT3SShYnu9Dph502MoqxeKybHfg3KcRGoU56OnGwNrjptlE
         UHKWl/e62Onponsj8EQZgosG3EtRS+y2Yic+d8iiD2SegkmZmkU2b6sQGanrk2g0qbrc
         hKzw==
X-Forwarded-Encrypted: i=1; AJvYcCV79wcXSrCNPWgmtNEx6t5Fx+qgwGZw783Tfu+YXpGCK2yifNqqDky2GaegisCXikSpy2pErEKAFoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO1y3Fb1XpmpMT0TaMA7xufEPEdMz8H6+X/tQA4lTlboPOqqBv
	8DWZoE5ND1APQfOwzcInNTMt2kFt+YIWQxtNpV5ouDD9WmdZBlwwSbMFgE30Ti78jF+OxH6utIP
	ejIih5ZfZM9Oe3G5/p46nNoKBNLaY0yU=
X-Gm-Gg: AZuq6aIEk5JPT6oVp50krBgnkHnUKKyvt79nnxTQn1D06wvcJSV7Fd4hux8lr0l0XDW
	/a9Q4kh/QV4svkxsFbQEqx6P1GMhVeXXOPQeaqx/YlcwfreXkYXaT1auPHEEG8IHuT0hIDPGSBG
	vHN2dyhS3sRwzi9hnPxs19M1Bb0CghIFVNdLrTx7AzAGGNX7so7XqB2QUuvy5T3N46ddfmcd+8D
	LqATEIcLtsxU2DhW9MAC4hxgv6nyClbRDyvy5dBxvBJgLbZbXb8q/++Ypqzjc8r4XI2WQ==
X-Received: by 2002:a05:622a:c8:b0:501:502b:8c6b with SMTP id
 d75a77b69052e-505d217b5a5mr58752171cf.9.1769814811697; Fri, 30 Jan 2026
 15:13:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118223344.92651-1-john@jagalactic.com> <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <0100019bd33e43bf-bb49e98f-284c-475b-a027-13c7271f67bf-000000@email.amazonses.com>
In-Reply-To: <0100019bd33e43bf-bb49e98f-284c-475b-a027-13c7271f67bf-000000@email.amazonses.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 30 Jan 2026 15:13:20 -0800
X-Gm-Features: AZwV_QhZcPdEqRRUkE10n-Q1UjWagCWtvDsztQQ9CRVvisVS-xKBB72jFQNvlFU
Message-ID: <CAJnrk1YNRNRrXVydX6=5NAic3fu6QggbA5xV2fwywP27yZu2ZA@mail.gmail.com>
Subject: Re: [PATCH V7 17/19] famfs_fuse: Add DAX address_space_operations
 with noop_dirty_folio
To: John Groves <john@jagalactic.com>
Cc: John Groves <John@groves.net>, Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	John Groves <jgroves@fastmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, James Morse <james.morse@arm.com>, 
	Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2026 at 2:33=E2=80=AFPM John Groves <john@jagalactic.com> w=
rote:
>
> From: John Groves <John@Groves.net>
>
> Famfs is memory-backed; there is no place to write back to, and no
> reason to mark pages dirty at all.
>
> Signed-off-by: John Groves <john@groves.net>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/famfs.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
> index b38e92d8f381..90325bd14354 100644
> --- a/fs/fuse/famfs.c
> +++ b/fs/fuse/famfs.c
> @@ -14,6 +14,7 @@
>  #include <linux/mm.h>
>  #include <linux/dax.h>
>  #include <linux/iomap.h>
> +#include <linux/pagemap.h>
>  #include <linux/path.h>
>  #include <linux/namei.h>
>  #include <linux/string.h>
> @@ -39,6 +40,15 @@ static const struct dax_holder_operations famfs_fuse_d=
ax_holder_ops =3D {
>         .notify_failure         =3D famfs_dax_notify_failure,
>  };
>
> +/*
> + * DAX address_space_operations for famfs.
> + * famfs doesn't need dirty tracking - writes go directly to
> + * memory with no writeback required.
> + */
> +static const struct address_space_operations famfs_dax_aops =3D {
> +       .dirty_folio    =3D noop_dirty_folio,
> +};
> +
>  /***********************************************************************=
******/
>
>  /*
> @@ -627,6 +637,7 @@ famfs_file_init_dax(
>         if (famfs_meta_set(fi, meta) =3D=3D NULL) {
>                 i_size_write(inode, meta->file_size);
>                 inode->i_flags |=3D S_DAX;
> +               inode->i_data.a_ops =3D &famfs_dax_aops;
>         } else {
>                 pr_debug("%s: file already had metadata\n", __func__);
>                 __famfs_meta_free(meta);
> --
> 2.52.0
>
>
