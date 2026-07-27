Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8049A378D8A
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162073; cv=none; b=p+UtOEfZXw0NQDaYsMHghf7Igo25QU2fg+w6fOh12SxVmN/0LLXja23YYC3fK/dniQ50SlyoP3G9yazhS91QOKRlo7C6z1AngyEJKwS47BS7EcTtf5qamYV4DU9NnKgr5w/vFUp2O4O6tPC1RCJbb6gUQz22ZMoRVjavTLX7Dvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162073; c=relaxed/simple;
	bh=trVscRWe6+DftQLAvCN27CV0yWYZ9H5pB5+fBQqdapI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FuaATbejNeHlKQn69VBHfRxHy67tElRHad/1TJENrKSHZZq9NJTQvIwT4n0KEDqMQcDeKr8lBp83C1BVZkcSLVWiwGVXExgL183QHvZECh/3pcegVldv12yUS5vhnqZexqMXwOoaak6rgTUlCntjFZHrfQtJ+KFR/5H0LTXu6LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xHmc9qGg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8uYyF34k; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CP8vzXHw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9nfCsWwq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xHmc9qGg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8uYyF34k";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CP8vzXHw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9nfCsWwq"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A25E67C2EB;
	Mon, 27 Jul 2026 14:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785162060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQ/RWrl5HCymn7nIlY1iYjPcVn8nFtx0IV5+GNqxglg=;
	b=xHmc9qGgmlwjnmwl9VlJTDWxrMLaNw5/qDx6XwewAfRmvF2nqhOgemESJwA/DIc9++lRxQ
	FfU1CMS/889LMWy+0HffsWkOD9jutRr/vzX4mbW86yfKAwnrONoOj6MNzWFX67H2yfsnH2
	d5h9WAZqKznGW3tdny08bVM3bcxyHv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785162060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQ/RWrl5HCymn7nIlY1iYjPcVn8nFtx0IV5+GNqxglg=;
	b=8uYyF34kulhf474+PXSu6E66i66DVS3DVnFAlBCPNQX1wtBIeBDVD4OCAuXpVFsvKrCa/2
	fvyi0hbjw4DLajAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785162056; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQ/RWrl5HCymn7nIlY1iYjPcVn8nFtx0IV5+GNqxglg=;
	b=CP8vzXHwGlxDdbUQhcanmkgjUE/agyaBBsasmUPcfAYZoHjS2pva2BH0c18qwB6oGfka/o
	waROPdbIZkKbwQNeLbxUA2fW1HDE4Rfb2Y2P4unOlI8omnk2PxGiJanmmxn3QQOaTRXIZ9
	kqVybaAkpRF3QLK7MiIhSNOSBUL89wY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785162056;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQ/RWrl5HCymn7nIlY1iYjPcVn8nFtx0IV5+GNqxglg=;
	b=9nfCsWwqGJMH04FIV2dzWtCFn6vNooFcTkPLcYIPs/4mwJkBR7L0Wwa9hcUZpPQuTn/gnu
	laXrENIEI46LmXDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3727C779B9;
	Mon, 27 Jul 2026 14:20:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cwXqAUhpZ2qlOwAAD6G6ig
	(envelope-from <farosas@suse.de>); Mon, 27 Jul 2026 14:20:56 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, qemu-block@nongnu.org, Jonathan Cameron
 <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng
 <fam@euphon.net>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Zhao Liu
 <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, Phil
 Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>, Peter Xu
 <peterx@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v2 11/12] migration/multifd: fix Error leak in
 multifd_recv_terminate_threads()
In-Reply-To: <20260727-fix2-v2-11-d0c4831ed7ea@redhat.com>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-11-d0c4831ed7ea@redhat.com>
Date: Mon, 27 Jul 2026 11:20:53 -0300
Message-ID: <87ecgopl8a.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> If err !=3D NULL, free it.
>
> Fixes: 11dd7be57524 ("migration/multifd: Remove p->quit from recv side")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  migration/multifd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index dbad525d2a28..503014f76ba5 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -1056,6 +1056,7 @@ static void multifd_recv_terminate_threads(Error *e=
rr)
>      trace_multifd_recv_terminate_threads(err !=3D NULL);
>=20=20
>      if (qatomic_xchg(&multifd_recv_state->exiting, 1)) {
> +        error_free(err);
>          return;
>      }

Reviewed-by: Fabiano Rosas <farosas@suse.de>
