Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE6535A958
	for <linux-cxl@vger.kernel.org>; Fri, 30 Jan 2026 22:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769813606; cv=pass; b=R23udmM/AHoq8CPGNgXL8AwjARPhf0Z9Z5bicAEHtBgqk2ps9U68Q0buBFkUCI0YbyBwhhi/vVMx1SU8pNMNdDKst7yjajlJzsaLZM/9ZnZJgT6n7cM+7wm40g+oNSa2iJ3izQaCYZlwfqatZEziOHQYITuMNTDE8uBsasxG1ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769813606; c=relaxed/simple;
	bh=I6AA9LJQkjtH8pRVXBRtk0eb0kKxzR2imNiewT90hbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fo+WM7TpjwU+gWhpVnpzo7kXxT2z3qTlZVqDDvjm90TlIygoua6uq3h9bUrtdmFKwSbhLk3H227tHpXqKWU9P+fc1JhxsgSVdRQrlN5RvzeRUsSFN+bfwRgqYoWrrymQdELmZjv9JBt6RY3b/VSlq6Gx29pplqi9gRR9pHskhsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuX4Sh3x; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuX4Sh3x"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-50146483bf9so29049211cf.3
        for <linux-cxl@vger.kernel.org>; Fri, 30 Jan 2026 14:53:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769813604; cv=none;
        d=google.com; s=arc-20240605;
        b=gxD2KDdhLkdpabGSXETRfqgiqMSPCudTfDP4c9zUy/MESpBYY79TYrlSXTN0+Eg7KO
         5byyxpnp3zqAPUVxs/8KMDzNYqx+6FDTKHT8BgW+r8CQk/UBx+CmENfFbQvibCMzPfm+
         8gdx9E3MSC4hlV/kpuE2kqY6knqhNFZ2RrB1VNdXuNKuAy+SG6rRUsKLt3qh4eOwTHoV
         V0N0ipalDvdHiqPJ1TBO39c7+R1zpAOqdH+PB1in3XJDrZ0djfvcW+Ap1fh7FcytEj3N
         JKLJhYzLzWHiJwtRq/ON0sIxLi30C7aeVgAW4gQs6M7eHyDfHX2+xuYSooC5BzRcqXvZ
         VJmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RvpDJGr4SwO80ntJbbklM7U7D7aCaEah0HNbCRkVHSs=;
        fh=rUsporxcgVKFMOqdsTCUzWddihi6dvGsL5CjAJOanig=;
        b=eX9m7ehUqRTAJRzHB6rfqe551auUfrsMnu3yE6iDXTaxMnLQG9Z5yignOBks8/iGcV
         zvq3pJGbl//ldIH5YUu4btPeImxi2+q4BRngGc8cTgZFyfjlKnFOLKrlVmRTftMVa2ru
         XsiBCnf3axP8YYMpqCiNwvPXlvd1Tl4vHNQ6Gfz6AFBDVNalTTeLVMEKdytgpoUFKAIj
         j4t8p2BcNsSfIDtZ8vfUgnxpyAao1YrZIvFxp/ya2qTsqlXCYq8Ueig5Rd2+oDvD+aD9
         QRR9CSsrRpdn7pXypXUwd8QH6r9uZ9qE7ZGiP3B2YV61tb7t1POcI/uygBjWezBVkaOf
         Nd6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769813604; x=1770418404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RvpDJGr4SwO80ntJbbklM7U7D7aCaEah0HNbCRkVHSs=;
        b=FuX4Sh3xtBiDnHAg9EFEEZ2NvuXwTyuY5kH5yeju3QvvNNpRwES0yiHLoqFqYCEzM/
         erqkzG8/DUskaWzzQur0Z5aWpXSXuzDpNUpc9MsRR1GDIS9QKij2f8A3hPSiC/IkpuEw
         ltrMleIWg+zQSK8wVnGP5P4RVf1jv3GorwW9ObvyRVB1A80qEviOSF+GUDHIenpm5U+i
         PT3DhhATtxe6fYVpEf1U9qiN5Ckh26v87FKM4gybE412l43MPoKrsy7k6bUa3rjv2Abc
         5ToqgZmyRng2xg6qMNxdyjcWzow4ld3hwb1N6SfWwpclON182bdqNIfjaiy1lNmVXAG8
         J/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769813604; x=1770418404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RvpDJGr4SwO80ntJbbklM7U7D7aCaEah0HNbCRkVHSs=;
        b=XynpLAMS+jS1KVNefDhsamuCRazUAqJ0FQbgylCfdlabLofWc7KfbvREASHcEYYyJn
         zS5UjEzFp9ligFbqhYNJR8sg55PGhxK9qOOpwdP9WYKhXsTnCR914E4WEsS5Y8GknTfO
         zWp65tMTT5hz7mjIy8ccRBAwLtxFLIP52vqsQ03sUfs7WCVsQEjFQkbFkDIy62308X3C
         B8aaCF4livfoVIRuXP1hhEMpWRc4/QBdYtfBaQZAqT7Q3Z+8KqWpYShyBz4gIxCn1sRF
         Q+bldd+Z0Rqr3Z4j4ksw0tjLprHgrOVB6sgofKUVWlWurXtOOIU6oxoQGH24Irqfl8FK
         6drA==
X-Forwarded-Encrypted: i=1; AJvYcCWTP85PUnUKl2J0pY4i7GsWrcJVy3GHvXs62HQJIKChn1kfi9jfZwEkIPSXDbT/8E/JN/T9y5I31R4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRpPScnHUVtDx6Qg4D662v6tL+5AluKazQS0M/XyTgRyEQHaqz
	Kq1Z0vX0YEXlv/Ya9XBN8N0bqMcLoIapQ60zG7hn+T3oTylgABDrayp/mgPP/3OAPPICGUEeU2y
	CNOblL3OfogcwmpTEF+/CH0ArNbBCtLk=
X-Gm-Gg: AZuq6aJU8rhO3rn2SEg2NcDiplE0o38VqGxXiyTZy2Gx1fKr9xMlehmCMhpywUZ4JEI
	u61JxKkiploIH44ZENv364OtMgAbc5uSdOrLlMc7/8ofp5KW94Jrb/CZWQbusmJUWFpUL7q9tp/
	qouz48UW/r742lQMdfea4MttGENQmleZAH8WvAudxCBvCaZ7pkfFqj0jsLaJsyFlXJ3tNAgt9GB
	2GLpxeGel9op3Jz/a8zIytj9izxnLGdHmhu1W400gQ8H9KsX/eav64H6y0CuIq3tvHAbw==
X-Received: by 2002:ac8:5ac1:0:b0:502:9f71:6458 with SMTP id
 d75a77b69052e-505d223e5afmr53898871cf.44.1769813604047; Fri, 30 Jan 2026
 14:53:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260118223516.92753-1-john@jagalactic.com> <0100019bd33f2761-af1fb233-73d0-4b99-a0c0-d239266aec91-000000@email.amazonses.com>
 <0100019bd33fb644-94215a33-24d2-4474-b9eb-ddae39b29bd8-000000@email.amazonses.com>
In-Reply-To: <0100019bd33fb644-94215a33-24d2-4474-b9eb-ddae39b29bd8-000000@email.amazonses.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 30 Jan 2026 14:53:13 -0800
X-Gm-Features: AZwV_QgH1KMH2vlFTNGo85feW4dv-AHS4Ad-yDU5HTglx7x3SJ0Y27UEufrkPHc
Message-ID: <CAJnrk1Z9BuCLZv576Ro9iYUPRDpW=1euG0rQ2wC_19sBcR18pw@mail.gmail.com>
Subject: Re: [PATCH V7 1/3] fuse_kernel.h: bring up to baseline 6.19
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

On Sun, Jan 18, 2026 at 2:35=E2=80=AFPM John Groves <john@jagalactic.com> w=
rote:
>
> From: John Groves <john@groves.net>
>
> This is copied from include/uapi/linux/fuse.h in 6.19 with no changes.
>
> Signed-off-by: John Groves <john@groves.net>

This LGTM. We could probably just merge this in already.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  include/fuse_kernel.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
> index 94621f6..c13e1f9 100644
> --- a/include/fuse_kernel.h
> +++ b/include/fuse_kernel.h
> @@ -239,6 +239,7 @@
>   *  7.45
>   *  - add FUSE_COPY_FILE_RANGE_64
>   *  - add struct fuse_copy_file_range_out
> + *  - add FUSE_NOTIFY_PRUNE
>   */
>
>  #ifndef _LINUX_FUSE_H
> @@ -680,7 +681,7 @@ enum fuse_notify_code {
>         FUSE_NOTIFY_DELETE =3D 6,
>         FUSE_NOTIFY_RESEND =3D 7,
>         FUSE_NOTIFY_INC_EPOCH =3D 8,
> -       FUSE_NOTIFY_CODE_MAX,
> +       FUSE_NOTIFY_PRUNE =3D 9,
>  };
>
>  /* The read buffer is required to be at least 8k, but may be much larger=
 */
> @@ -1119,6 +1120,12 @@ struct fuse_notify_retrieve_in {
>         uint64_t        dummy4;
>  };
>
> +struct fuse_notify_prune_out {
> +       uint32_t        count;
> +       uint32_t        padding;
> +       uint64_t        spare;
> +};
> +
>  struct fuse_backing_map {
>         int32_t         fd;
>         uint32_t        flags;
> @@ -1131,6 +1138,7 @@ struct fuse_backing_map {
>  #define FUSE_DEV_IOC_BACKING_OPEN      _IOW(FUSE_DEV_IOC_MAGIC, 1, \
>                                              struct fuse_backing_map)
>  #define FUSE_DEV_IOC_BACKING_CLOSE     _IOW(FUSE_DEV_IOC_MAGIC, 2, uint3=
2_t)
> +#define FUSE_DEV_IOC_SYNC_INIT         _IO(FUSE_DEV_IOC_MAGIC, 3)
>
>  struct fuse_lseek_in {
>         uint64_t        fh;
> --
> 2.52.0
>
