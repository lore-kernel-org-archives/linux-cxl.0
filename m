Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2593A331233
	for <linux-cxl@vger.kernel.org>; Tue, 27 Jan 2026 21:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769550959; cv=pass; b=jFADEzAkthvvBK/MVDzRT/JkJ/f0F8DCYawCTgVP0F4xuYmWY2R90V484FVHiWe699zpRCybk2R90IesygVtCK2kN4JIrj1SwKFUNTDle8Gs02G4tp2A0vscoluNNCNhH1V8Oygtpg4SjN218MWLoVJLGlal5LPERDLXlWbPDp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769550959; c=relaxed/simple;
	bh=8m6SHPVdIWrcyh2aRGiyHcnuhF1GhzjV4UbqBqvwtjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pux9uoAxLW7xYv3gc0UdWY3KXM6nDmDQ4rW/lt9wifaNFEBEE88LjOa5dn6HyXl0Dmfw4fIK8tYTR8E+3r3VtNkRsQxVSY+rVjjWyM91KPqukAt8H0zUYhf+szuDK1mbSTDDClXBCTOpytRbysQRZEETIsJVrM7S8d78Ixa2sVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ix+lNivl; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ix+lNivl"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5029901389dso55769361cf.2
        for <linux-cxl@vger.kernel.org>; Tue, 27 Jan 2026 13:55:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769550957; cv=none;
        d=google.com; s=arc-20240605;
        b=gQ2jW4dr6OEddKH8QdIuIk8erg+5JLQr/Xthq0QsHgeymS4nW7PvIX5nw2TUOATO1T
         0KcV34PNA3WqwiHrsLOn02zDHiLZwzgEB+XXfuVnNFuBLbhCy/63mriEfd2eKF5cDpID
         dS+uF/Jgq5naGBgDGYYG4DAsH61XRatNt8i3lPRI1nAzkTGEoan+HTZV2juc336tgIUp
         /xGOc+zk5F1HFd8lcAfmmSC/Y4U4j9Wh/mSs+V0963+wi4wtPPrpufOoNplKr8ZTe1q4
         qArSCHYrrkuEf7JhSIcJ8TSkcCbjGToSA2Q0NgtBBv3gktVBB0Y3nCxiDPHfNc56JR1q
         aEfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NKlFs0mQTNIoeYHTCe8czttQkA2EuwhIv5BND87JXOY=;
        fh=g/AleGbR6dmszebhQN4KC5u2ea/f+SrZPI/smbsD66w=;
        b=QAJggWyWAlvzqZhu6EHQgFjxLuDyxEpCsWLi6F2R83s94c44cTCNjNzISOO1l5IZSO
         e5NaDKPvH0KqFFKW9eecmrXyiLL+lmlQIyrt2s28GhYbHmygM9ee7FNq30jLtWvtdJ/x
         PlN7Ogrujys6+61WhlMSEU1ST7Dg+CakoTTdt3GbN8BNZF/Oll+f3Xn4qBOCuU1lhctz
         xxAgM/ZOHnpYNYsp1aCsVHLGTgLPsj/TjqzzZUt99OIpAeGVisQCQ+I5sO5Ov1o5hulC
         CWuwKZC4XBxhgrvTVgEZtUrqDQMnzfvDohKqRS4mEVpDOYxZ7O9aCTzzVah97y6oRc1u
         twMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769550957; x=1770155757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKlFs0mQTNIoeYHTCe8czttQkA2EuwhIv5BND87JXOY=;
        b=ix+lNivlr3lyDXAuHr9H0DGq1g3Qt/dJxnKBg+40FddaJGs4dWOKK1/OlODc5ZqYJB
         k/ni//D0zoZGihJmfE+OX2T7mPfdv8jwxYW/VuqzpghxwH8urb2UoF20+fifIFcnFlwY
         dYRuDywReXrDcVEvYRbCm2IV6r87jPb/zga/nbF/Yz5Cj/iI0w6glXt5qSUghAwy45RP
         R6HDS0B3lCT8fI7owiMBkmYuZ2Fl8ik7lOtC3mdng4Eb86bEKOs67t+8aI6e17wJ9Ncl
         lahXUPAgkUh6615b/DYUpz+XK98/Mov5xF8DGilVRD+KnhRdF+FCuLPS69nm+6mg4xaP
         h2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769550957; x=1770155757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NKlFs0mQTNIoeYHTCe8czttQkA2EuwhIv5BND87JXOY=;
        b=gPCPYth8m2qy9dtgWanVch7n4+WMFM0s74Er8Rxo2X+8SGnqmmKIam+cSYmWeA+IjE
         vJlTvEmRQzAK08+aq84soK1uMTrDXhcBCDqKNBtuRMUrXdfmhbmkcXAk9FqiVrBXlXpA
         tyg7yyPthtzcg3N4CxIWU7cap+EUFGm6NDYZ8qPbr27FhyOPjGXyMrcqhJNQqJwObq0F
         jwH8Bi54dEuTgyjoIWbQWVrwmQTPV9/gI/N48HljONGJoN8P5Yr/X7571J2ucpcm0+NF
         YJlLdulqDxVEpzT2x8x4pYmCG1VuzmZrWvlwm2Rse8XtlQJvktKRkpfmJQZczloqGtB5
         bdjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwMfAKGGpx1kTKsB6uaaU5NQwEeYqCmHY1qmahTUgdxy/XRg611yYCxzhtEM/4Z5dVDf5secDAtiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKctmKfJAkPVC0DIYEH6zpM3nAT8Qc6bdoqSIrH/WExP27L+1h
	MstvCzeg5S63+CoKd57F7wzCt/LczaQuiuUZgI5pGYOjTWdDxSrgu9uqf/0rfvaK03mIf5v/uJr
	fdNsiTYBfuJYmglz00JZ5rLim3oDl4OA=
X-Gm-Gg: AZuq6aIsj8V+t/J6L1nw2U5vrxzpBH5VTbBiIfNf339cucie63IBEOzsjrgwMrgrl/N
	gTrV/B83J6RpsevHJPcsl2z7/iprtEKEs/sy0S0hvUk1KM3Ff1EHTeZ74u3UvQGlzLStCP/XEoa
	HzM+aeO2+43b+wwfSLJDAoR1Bp9Nty9lX8FJK1b5c+tBh1xbCXGCXWQAQE27TC5y7QkVTMxwFs4
	OAEza45YVNzpmAaQk3RQL3ICNkz4M1moHXSQ8jxQTm6pcyRl2XoICmrig6jk6jWnJzQLA==
X-Received: by 2002:a05:622a:311:b0:4ed:a6b0:5c39 with SMTP id
 d75a77b69052e-5032fc1341emr35550071cf.63.1769550956926; Tue, 27 Jan 2026
 13:55:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116125831.953.compound@groves.net> <20260116185911.1005-10-john@jagalactic.com>
 <20260116185911.1005-1-john@jagalactic.com> <0100019bc831c807-bc90f4c0-d112-4c14-be08-d16839a7bcb6-000000@email.amazonses.com>
In-Reply-To: <0100019bc831c807-bc90f4c0-d112-4c14-be08-d16839a7bcb6-000000@email.amazonses.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 27 Jan 2026 13:55:44 -0800
X-Gm-Features: AZwV_QhPL9Sj6DMGNjDww4OFl9nGLOsm6aFs6t6n1KrqwkFwyhPAYsBkmAeTikQ
Message-ID: <CAJnrk1bvomN7_MZOO8hwf85qLztZys4LfCjfcs_ZUq8+YBk5Wg@mail.gmail.com>
Subject: Re: [PATCH V5 09/19] famfs_fuse: magic.h: Add famfs magic numbers
To: john@jagalactic.com
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

On Fri, Jan 16, 2026 at 11:52=E2=80=AFAM John Groves <john@jagalactic.com> =
wrote:
>
> From: John Groves <john@groves.net>
>
> Famfs distinguishes between its on-media and in-memory superblocks. This
> reserves the numbers, but they are only used by the user space
> components of famfs.
>
> Signed-off-by: John Groves <john@groves.net>
> ---
>  include/uapi/linux/magic.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> index 638ca21b7a90..712b097bf2a5 100644
> --- a/include/uapi/linux/magic.h
> +++ b/include/uapi/linux/magic.h
> @@ -38,6 +38,8 @@
>  #define OVERLAYFS_SUPER_MAGIC  0x794c7630
>  #define FUSE_SUPER_MAGIC       0x65735546
>  #define BCACHEFS_SUPER_MAGIC   0xca451a4e
> +#define FAMFS_SUPER_MAGIC      0x87b282ff
> +#define FAMFS_STATFS_MAGIC      0x87b282fd

Could you explain why this needs to be added to uapi? If they are used
only by userspace, does it make more sense for these constants to live
in the userspace code instead?

Thanks,
Joanne

>
>  #define MINIX_SUPER_MAGIC      0x137F          /* minix v1 fs, 14 char n=
ames */
>  #define MINIX_SUPER_MAGIC2     0x138F          /* minix v1 fs, 30 char n=
ames */
> --
> 2.52.0
>
>
