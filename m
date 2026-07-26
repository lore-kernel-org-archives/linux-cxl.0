Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56853783B4
	for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 20:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785099163; cv=none; b=pgA8yOKApDhN32ik8hDeVx1tlB80nGjBu5O/SyjQaDTP2vBPf8hVCnSxq1nikivpEEKCKv4O5t3a/jruoVBtPp3Fp3F7fAwkGu/+dkrJ9r0z96blzFqj6gddq5kNNnb+/RUAkXi/xPEAv4WAh8KB3Qjvc5HT7u8ZPKmEOjrNTHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785099163; c=relaxed/simple;
	bh=m6sTZ3FQl9lUQaHJ38ca2HHUwxP2giUYLLcAY/d8p6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=p/vHH1wvsCkQy6TR457WlZZDkWJx+5YhMJH0U5/3B80Jsy1e8VMxLgJ2UJR0wuj8QWg7ecqY1FGFYGq1PhA5qz/GzglQGG8zpaHCt9CgvfBeyN4dMiBRF2yQqZj/uWZLzzlgwzyHyBsRcSZUdX3bAhFtac7DHkz+aQq+h3Sxe8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HPl00+wY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HPl00+wY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785099160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wt7wCGr/kWh/rgRmz0sqXsHGnxZnqsHOsUrRjkkQJfY=;
	b=HPl00+wYCKrIhZgSgrrSo5QQgu6lKc5xqotyhDAIxPpwshtPRL+AaIDcuL+53LWqY9muHe
	3MmFvcW0Yrwfoke9AMlCrI4+mEA3da8hR7QSICr/d0nlKgQCA79N6qx23yVdQgeBvFeZal
	UtwXRw7fopQY0N1IQ3nBruhJ8KYSZIE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-dHnnjqGJOEaV-MNIjEl9mQ-1; Sun, 26 Jul 2026 16:52:37 -0400
X-MC-Unique: dHnnjqGJOEaV-MNIjEl9mQ-1
X-Mimecast-MFC-AGG-ID: dHnnjqGJOEaV-MNIjEl9mQ_1785099156
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4954c2d4081so15437045e9.2
        for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 13:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785099156; x=1785703956;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wt7wCGr/kWh/rgRmz0sqXsHGnxZnqsHOsUrRjkkQJfY=;
        b=NwemAGbZh0nuQThy7VMo3swM1YOwNy5nDF+9R0kvVxI/BP1x1phvlsofcVNpBM9YXF
         vWbVvpMrPMen5aAxHzP4sBm9lS/i48ZxbpMvNj9Qt740ViWWxLrsZn2rXcW9bsBH/N8S
         CxkNhwbfdMJYz2KSg2KA+Kj3F84twFwhs3Q4rRO61ACoHxEVRsQo+az4hvSqNNy0uC5a
         Fd9O2WUrNtRr3S1pu3PH0cm603fw4Wbk7/CWyQd2DIPfoUvoFyD1+8eLSM41fg/BnVxV
         fu07fEqT1+PB4C8INWuqdhQOgD3MFOI2vgy1uwuk7RShf6l05lCX0DnUmpcfzUDg9XS9
         vY6A==
X-Forwarded-Encrypted: i=1; AHgh+RqxvWj7NG/eZmRXum2qlEtWQyf1RHOIasQljDDUmNAjPII5a2TA99xGwP6C68VUfPDxWJvvmaHy2fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWd3aTRCEkTagm+l9+KqZogmjE2fwcZjIpbk0lNK9rZp0TUMt1
	dmOY1b3F1eqTByEjtpdU/sPgjO3cta0G+dpLhez3lBbeu8SgG2Xx6yDpHyq4VU0HczdFHu1aoCx
	tDq6OXm90rpbQPqP2piVjGElpY7SakRkKmgjXrUUni6hSihU7zVCW7gUvT3jCqA==
X-Gm-Gg: AR+sD12GQrJzr2CBEsZxestwGix7YDoFenUkR3Ek7cFv9ivjUGXQebRe7rhdh2FQNRQ
	kz07e/hzQA1+TxhUI+84r89YWrQPfI8qGO6bh92ikuBeoqO50iDBUU0AkuY7RKqHd22cT8OOEU+
	Sc2ZbkuIt5AOu0VtchTDlsgeWPEYPMIU+8mo9plR+XJU1tgHlfgli5urC3u9/3tBrClpcC+OQzU
	FsTRnukYaNDbTtykJjo7a4mT3/youBx6TwtgSzSzoBOOaok5H/DIABJa5rFm5EdkEPTyNRQP1KN
	3r0ZjPeo00YbC8pQuUbRJqpGHRAj6pJd7VPYFfq5ntNJ66xzPGgLqKgSCt507dPJhaQEMVFmtRa
	j43KmLpDpFqMvDslDy7G3YA==
X-Received: by 2002:a05:600c:1906:b0:495:3a52:cd7e with SMTP id 5b1f17b1804b1-496b5700144mr88494025e9.25.1785099156282;
        Sun, 26 Jul 2026 13:52:36 -0700 (PDT)
X-Received: by 2002:a05:600c:1906:b0:495:3a52:cd7e with SMTP id 5b1f17b1804b1-496b5700144mr88493725e9.25.1785099155846;
        Sun, 26 Jul 2026 13:52:35 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bd9e980sm192229905e9.0.2026.07.26.13.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 13:52:35 -0700 (PDT)
Date: Sun, 26 Jul 2026 16:52:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
	qemu-block@nongnu.org, Jonathan Cameron <jic23@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
	Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Roman Bolshakov <rbolshakov@ddn.com>,
	Phil Dennis-Jordan <phil@philjordan.eu>,
	Wei Liu <wei.liu@kernel.org>, linux-cxl@vger.kernel.org,
	Brian Cain <brian.cain@oss.qualcomm.com>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
	Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 07/12] Fix some -Werror=maybe-uninitialized
Message-ID: <20260726165049-mutt-send-email-mst@kernel.org>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-7-d0c4831ed7ea@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260727-fix2-v2-7-d0c4831ed7ea@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GDsryqnvlah2D4FLwBb7JVHyE14TWMA97iyKaI1xDvE_1785099156
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 27, 2026 at 12:44:06AM +0400, Marc-André Lureau wrote:
> When compiled with -Og, gcc produces many false-positives
> gcc (GCC) 16.1.1 20260515 (Red Hat 16.1.1-2).

it hurts if you do it? so don't do it then?

> We already use auto-var-init=zero, but better be explicit.

explicit about false positives?

> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  target/i386/cpu.c             | 3 ++-
>  target/i386/emulate/x86_mmu.c | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 5805d33ab92d..28e4435df23f 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7734,7 +7734,7 @@ static void x86_cpuid_get_avx10_version(Object *obj, Visitor *v,
>  static bool x86_cpu_apply_avx10_features(X86CPU *cpu, uint8_t version,
>                                           Error **errp)
>  {
> -    const AVX10VersionDefinition *def;
> +    const AVX10VersionDefinition *def = NULL;
>      CPUX86State *env = &cpu->env;
>  
>      if (!version) {
> @@ -7757,6 +7757,7 @@ static bool x86_cpu_apply_avx10_features(X86CPU *cpu, uint8_t version,
>              break;
>          }
>      }
> +    assert(def != NULL);
>  
>      if (def->version < version) {
>          error_setg(errp, "avx10-version can be at most %d", def->version);


what does assert have to do with gcc warnings?

> diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
> index 8d4371467fd7..65bcccd4751e 100644
> --- a/target/i386/emulate/x86_mmu.c
> +++ b/target/i386/emulate/x86_mmu.c
> @@ -185,8 +185,8 @@ static MMUTranslateResult walk_gpt(CPUState *cpu, target_ulong addr, MMUTranslat
>      int largeness = 0;
>      target_ulong cr3 = x86_read_cr(cpu, 3);
>      uint64_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK;
> -    MMUTranslateResult res;
> -    
> +    MMUTranslateResult res = MMU_TRANSLATE_PAGE_NOT_MAPPED;
> +


This is not 0 as the commit log implies.



>      memset(pt, 0, sizeof(*pt));
>      top_level = gpt_top_level(cpu, pae);
>  
> 
> -- 
> 2.55.0

