Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D93472F9A
	for <linux-cxl@vger.kernel.org>; Mon, 14 Sep 2026 13:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391795; cv=none; b=S/hZM/h+hZvlg9KsnLVpWxPJe7pIApYm5fjN0W2WD9GyoXuzjFV6uFkfaeICcgG00GKC0YQUD2cmu3CcPxhJY1QvSOpC9LpgIc1eQMSETodwNZvb3ae9jammUDD8hiO3EOBTJqsOo9g0meddbPFLLKjI7eW2Ai8qljlGy/gW7Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391795; c=relaxed/simple;
	bh=VZWgiJ4JRiGmbgpyrWVZJtAWsFo7nIvh7lqunQoaS6c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TCP8pPD8bLbakCmbKC9px4Sp/FqFIAXdyYvJvl83zsqOWvHC2pN93zJb+DRQcu16E01qxAgDktOWrMoZeH/IJRhsOfq2Z4/PqEHbnwDxgXxD5aCOuUjZ8QBx4wM2xyMkFvMuO3il4oS0mMEnjEa6nqicKcaOBhfHhSkVQlj8FYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOcndyVo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOcndyVo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10161F000FF;
	Mon, 14 Sep 2026 13:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789391794;
	bh=PgmvsZv1VBpwiOwuLDdoohIMZbS2Zze5B0knc/e1H/4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eOcndyVon75X13jGSocFIPd5JALbBIFTwLuiVgZJD84IicQEU6WQedLdDtbRXdl/7
	 3n22yeh2zQY0aCaSa06gQqCEaZUr5c7CwduODA2og3hqRq6DyZhxBC4Cbug7pgEbL2
	 2u/X+KymFw5R7xt1IHHhR3tRGDo3yIq9sCwhZ7CamKhw3ADqOgwRyrTbk6YwEAP0JZ
	 HFsqoYngqGifUxLKbbo5p4GXs69ZcRxuAemq1JNfWYmiv9p7Gn/xiBotw8w4DTha51
	 zbA8wztq0UfoVp8Q4NvL9mkzsPxneoq2n+XNhERpOfq/C9M2xk7ME68Mqa1tYAj6j6
	 N/Bg9Gr07vi+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] cxl/mbox: clamp the event record count to the
 received payload
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gaobin Huang" <huanggaobin23@semi.ac.cn>
Cc: linux-cxl@vger.kernel.org
In-Reply-To: <20260914125701.1160136-2-huanggaobin23@semi.ac.cn>
References: <20260914125701.1160136-1-huanggaobin23@semi.ac.cn>
 <20260914125701.1160136-2-huanggaobin23@semi.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 13:16:33 +0000
Message-Id: <20260914131633.C10161F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but EDAC memory repa=
ir state storage is improperly gated behind a tracepoint condition, breakin=
g memory repair when tracing is disabled.
--

commit 4e03b22d8d72d66a9d7ecd79d1ff3eb2082c4880
Author: Gaobin Huang <huanggaobin23@semi.ac.cn>

cxl/mbox: clamp the event record count to the received payload

This commit derives the event record bound from the mailbox command's
size_out to clamp the record count, preventing out-of-bounds reads when
the device returns a payload smaller than claimed.

> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 55828a836c01a..a8f51bf0ffc7c 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this file I
noticed EDAC memory repair state storage is improperly gated behind a
tracepoint condition in cxl_event_trace_record().

drivers/cxl/core/mbox.c:cxl_event_trace_record() {
    ...
    if (trace_cxl_general_media_enabled() || trace_cxl_dram_enabled()) {
        ...
        if (event_type =3D=3D CXL_CPER_EVENT_GEN_MEDIA) {
            if (cxl_store_rec_gen_media((struct cxl_memdev *)cxlmd, evt))
    ...
}

Because memory error records are only stored when tracepoints are active,
doesn't this break EDAC memory repair (like PPR or memory sparing) when
tracing is disabled, since the records will be silently dropped and
operations requiring them will abort with -EINVAL?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914125701.1160=
136-1-huanggaobin23@semi.ac.cn?part=3D1
