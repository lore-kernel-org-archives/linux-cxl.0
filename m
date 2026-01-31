Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324E01CAA65
	for <linux-cxl@vger.kernel.org>; Sat, 31 Jan 2026 01:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769822326; cv=pass; b=Ab57/1yKU/w9ESb7VmMLc7a0PGnq4R/luF2woxGA4Zby8zlcsCYdWkUVDYmInlVMkyHCPPT27hwgOAHf3Iumn95YpwNJ0wIAp7WLC4OKn5/Vg+/+NCBNic09pTXGGY/yhqdw/dzc292lDQRGNRrCpQoENyUZXxbGgY3vhT3l1Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769822326; c=relaxed/simple;
	bh=NJyyW3LrV2W0dVysafPoC2cjKhBb+MYi76erl20GHWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzRno1TRgPGECGLOxXOklOITsWb6H6O5EKuBu1vYxnrM8HBawmINzJOAgooSMB3BSCCsRLfAC+W0Bt1QAo2Y72li5Uf5Tmiv7/naAIl709SI5yO3PCmM5g0ZzwkBbKtZQP2tMJze//1JXHbPhDcwf51BimhC9ULoPASn/KzXjzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSNneL6Z; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSNneL6Z"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88888c41a13so33172576d6.3
        for <linux-cxl@vger.kernel.org>; Fri, 30 Jan 2026 17:18:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769822323; cv=none;
        d=google.com; s=arc-20240605;
        b=gglYSQ5lnqJrRdjzDiJHh1WbKfJLp09zUfRHUiuxwJaRaOV6FcN3zqfPCN5NGAxgGt
         srDx6Tu5Y/Y3Pum+/cXvFptwwg81bvzL2fwrEkHn/Dhqitbd5tP0LjrD4vWS9xaChjZb
         W77pshYayl5ILSGDjyYAUVTiL8OCUPlu//VocHRNlbQkd5xKCV81o6ZYXsGICdkmVcxm
         /XCmxUaqnKyu7uibOEqtUIvWKWznv5AWr3OC9ZN5dE7o/VJTz0+6VTFP2NUreeq5+Q8e
         gUInpbfkDLaEkBG+5evejPBdW6PXTI/4ZOY9zwXUZSHhyLmQzlzuZpldIHxkUen+VHOW
         kNZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C9hrsBRNghnIovdQhJmal8FXOCZu37oJsf0hDL/41Z4=;
        fh=JCeR6V31DDLh3KO8DlRMOD8ZQeUfwjQ69Ll505mmxZg=;
        b=fgtKyGtqOhA/fx9XT3pH0KAPN3Pt3cLfTgrgjcghCa1WHmIZK+VfadP/xVI7UJS+8L
         /EehwPhGAtEfb2qwYK/5n0tOFlJscwT5mw1QPs6OxR27g/8eebSyZB8ps5OJd89Sk88/
         H/+Nn1XqQLwOBAt65BjR4dehRfB9wKTFQ4GUT8dU83IvIPowDX0dj+PuLaVpfahAWIZ7
         yIKIqQQ3Ow8Ywpy6ZNoUnOsTqhpiGVGndcYUGSDB86kLrK4ZXUtqrHnGU7lG//Vm9iSQ
         z29IlYI6r7iKIz57d+Li/TvXy3+Sp0J1kIHcGYfT5h+s3NuseH3A96LrpqeWLwl4IQSx
         glTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769822323; x=1770427123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9hrsBRNghnIovdQhJmal8FXOCZu37oJsf0hDL/41Z4=;
        b=MSNneL6ZdYS1vduzZenv+A58CJIG8UdamLkhXnr/8M8qRF6bLvW4xnwm/VgGelXIFl
         Tj/cfvczfvA6tQ7Rm9CtQeA/gDpKESzHzdYX3VXFWA/1KF0MBZHAykOv0tVmtfUzOKda
         qId3vRNxsCijXl/sjwUwZpmCNLUFkJl6DAozGBUgGOerPhHa2oxWGbTNjX9rkGalHfOX
         VED2q3zf5UT5E7EZl45MKecY9pOLuq1uWqbZQDFz7qZcHEA1CXd/HtVlQdbZ/UHBJF1x
         eJo384AlDBIPIADVGL5ZVUe+CTjBbQm+HXsDgVxVYtjifhX4Cno7a40hCza5Oxu0el8S
         3CRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769822323; x=1770427123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C9hrsBRNghnIovdQhJmal8FXOCZu37oJsf0hDL/41Z4=;
        b=mrzYag7eS0b/cqML186Wcgd8QDI3+ayhdUNZj+5kBkE8zrdEbN9tUpAd6ZbImXgQ3a
         D+Y1JO0+kqnxovkA4O+MzM2lTz3vsGc+VkEz1ZrJiLUQnIYRJJ+XTYT1jRulcNftF+bE
         6zW317swdaSGSvReThNS980aSEb3Ar4KD1jRnuh5wSGBhRnIvtiLpMaDxSwO2L3L9Odu
         1Ie9cG6FmI3eIWxzdEMCyaiBC6g37ZPIVs5fRLHYNtKZiNbNpMlqoSU1GWR5dZBA+w63
         JCSA09NFAeUPRUEzjbaMXA3wwFLyggQKTagEtA/lRhlGMFjgY/TaPcKh+4rLfFfopz24
         ZO9w==
X-Forwarded-Encrypted: i=1; AJvYcCUaiItS317gIW3hHKNRyiBfXo7gJQF1LAlmQoGVM9kK1PUI6VEZppHdPGs5idwFc8Xs0croiy6Kbxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3gSpiRZTqudRbajUVywYEKQGGINXtDl1ROHntmMFHI+rfcusD
	VrBxhXRshrHY7r2B19rekdVWsvvD9qVwVe4T6rZ+82Iec5xQK/JcrNSEi8znZ6hsD8EsF2ayne3
	UZP4ufC1wV3fJkX+cGav/zOBqEeMkjKU=
X-Gm-Gg: AZuq6aKrm2MMot++cgG+NSKyG2CnoOyGjOuuqhIoUFxHRojwVh9tX2WSAQCZCLoHU3S
	651mLzBWt6jQKqfdjyH7CU+Z2T8oJiJWVQB/PQFlq6qZWEGw7Fii3O4wDlszPoBJ7Icat43sUbg
	HAs8ZVh0LMwgiV39xKdf57XqMKzTHrXS/IFsmEgH0dF2IXVofm57qcRtWvnJ/6ELGYRk7bI6W5I
	4klnY+8mYJw5oyfIwJGHmKcyd76P9WmoLlq6W0IWokeVaSFCC8g+LOG9sRwysfY5e0GlQ==
X-Received: by 2002:a05:6214:29cd:b0:894:2e09:335c with SMTP id
 6a1803df08f44-894ea06291bmr70047416d6.53.1769822323137; Fri, 30 Jan 2026
 17:18:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118223516.92753-1-john@jagalactic.com> <0100019bd33f2761-af1fb233-73d0-4b99-a0c0-d239266aec91-000000@email.amazonses.com>
 <0100019bd33fb644-94215a33-24d2-4474-b9eb-ddae39b29bd8-000000@email.amazonses.com>
 <CAJnrk1Z9BuCLZv576Ro9iYUPRDpW=1euG0rQ2wC_19sBcR18pw@mail.gmail.com> <20260131004119.GA104658@frogsfrogsfrogs>
In-Reply-To: <20260131004119.GA104658@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 30 Jan 2026 17:18:32 -0800
X-Gm-Features: AZwV_QjdwrW8pUbs14BS2iG7wgbYWMrbtNkfExGV1HlyGRZYGgSvmv1QKkg5_Go
Message-ID: <CAJnrk1adQktTTv=9_G=G_QDTkEZyCQgsPDd7QSGwwTsWk_4fEg@mail.gmail.com>
Subject: Re: [PATCH V7 1/3] fuse_kernel.h: bring up to baseline 6.19
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Groves <john@jagalactic.com>, John Groves <John@groves.net>, 
	Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>, 
	John Groves <jgroves@micron.com>, John Groves <jgroves@fastmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Josef Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
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

On Fri, Jan 30, 2026 at 4:41=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Fri, Jan 30, 2026 at 02:53:13PM -0800, Joanne Koong wrote:
> > On Sun, Jan 18, 2026 at 2:35=E2=80=AFPM John Groves <john@jagalactic.co=
m> wrote:
> > >
> > > From: John Groves <john@groves.net>
> > >
> > > This is copied from include/uapi/linux/fuse.h in 6.19 with no changes=
.
> > >
> > > Signed-off-by: John Groves <john@groves.net>
> >
> > This LGTM. We could probably just merge this in already.
> >
> > Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> >
> > > ---
> > >  include/fuse_kernel.h | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
> > > index 94621f6..c13e1f9 100644
> > > --- a/include/fuse_kernel.h
> > > +++ b/include/fuse_kernel.h
> > > @@ -239,6 +239,7 @@
> > >   *  7.45
> > >   *  - add FUSE_COPY_FILE_RANGE_64
> > >   *  - add struct fuse_copy_file_range_out
> > > + *  - add FUSE_NOTIFY_PRUNE
> > >   */
> > >
> > >  #ifndef _LINUX_FUSE_H
> > > @@ -680,7 +681,7 @@ enum fuse_notify_code {
> > >         FUSE_NOTIFY_DELETE =3D 6,
> > >         FUSE_NOTIFY_RESEND =3D 7,
> > >         FUSE_NOTIFY_INC_EPOCH =3D 8,
> > > -       FUSE_NOTIFY_CODE_MAX,
> > > +       FUSE_NOTIFY_PRUNE =3D 9,
>
> This insertion ought to preserve FUSE_NOTIFY_CODE_MAX, right?

FUSE_NOTIFY_CODE_MAX was removed by Miklos in commit 0a0fdb98d16e3.

Thanks,
Joanne
>
> --D
>
> > >  };
> > >
> > >  /* The read buffer is required to be at least 8k, but may be much la=
rger */
> > > @@ -1119,6 +1120,12 @@ struct fuse_notify_retrieve_in {
> > >         uint64_t        dummy4;
> > >  };
> > >
> > > +struct fuse_notify_prune_out {
> > > +       uint32_t        count;
> > > +       uint32_t        padding;
> > > +       uint64_t        spare;
> > > +};
> > > +
> > >  struct fuse_backing_map {
> > >         int32_t         fd;
> > >         uint32_t        flags;
> > > @@ -1131,6 +1138,7 @@ struct fuse_backing_map {
> > >  #define FUSE_DEV_IOC_BACKING_OPEN      _IOW(FUSE_DEV_IOC_MAGIC, 1, \
> > >                                              struct fuse_backing_map)
> > >  #define FUSE_DEV_IOC_BACKING_CLOSE     _IOW(FUSE_DEV_IOC_MAGIC, 2, u=
int32_t)
> > > +#define FUSE_DEV_IOC_SYNC_INIT         _IO(FUSE_DEV_IOC_MAGIC, 3)
> > >
> > >  struct fuse_lseek_in {
> > >         uint64_t        fh;
> > > --
> > > 2.52.0
> > >
