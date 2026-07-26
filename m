Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B35347FC0
	for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785051419; cv=none; b=Aps5qkapFh+26rrueGp9AeINDLNPkn1dkH8K1dh9Qt930fPLiqzzTxs0ZFXvWbGCvTnIAOWOY2LYtuw2cw2sCcqHKG/0NdSEjAxw0t3sqi+eSmc64GuSGgW382hWJBgajRTr6GiJ88MGJB3yI7e+N5C0d+TNduikeiwtKv5iqg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785051419; c=relaxed/simple;
	bh=gd475940lmiQ53+s6bcjz+oj6+rZ9A74ipyhAKzccoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qARWbtAiUPqo1BXglAdymyp++BFKfnvl0N1fkH9KKLc9x0WzZq1U7mbziV6GYuPwX2sN9sI/fqu2SOB8P/5crpj1YRWenavMlAAYY3xQG/DXzgY7bKXmJQjWglXmzwesg/4KZb8QNiCyQgmItWgpkvuTtToPQ2u5jNkB8Vzk85o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=DymS5woP; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="DymS5woP"
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66Q7asJp017140
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 26 Jul 2026 16:36:54 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=6BJYXjq4E/mraJBzuA/SBz5lQcftOsixHYEkg4LE2BI=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250326; t=1785051415; v=1;
        b=DymS5woP9pjja5iVcgJijDg2BORXKSyfZq6OCjrGoTvcs7fLUamp5pRqz08YwE0+
         rkgmbQNdywjWZTOT8Yd8/DUqPEI3b3S7SLojXokNZMraTrQinmClpF9e79V4yPvE
         jpbv7B57KZ2JFV2+tpST8ZydZ+fZ/EGfpix1PMlV4Vr2Dk70IpmMCQ8KUzAq7MT6
         B4NLZVMeGOJDtqI6NT3QR9GucNrGurV/uGvWBKT2S65B/YYxI8DxVI5RQtqkym8o
         A+Bt/SbnUwrUomP+OahbGhr5R+rmzPconhMhPg5oqjrNIuMou94J57WOpkDrO5Xa
         Ho8KQrkN8jvuwJ+fJe8Zxg==
Message-ID: <c1bcbefe-d2fb-4db5-a1ed-afebd0c74213@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 26 Jul 2026 16:36:54 +0900
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] block/blkio: fix error return value on getlength()
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
        Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
        Jonathan Cameron <jic23@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
        Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
        Phil Dennis-Jordan
 <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
        linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
 <20260725-fix2-v1-2-5c9a6ce7b96a@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260725-fix2-v1-2-5c9a6ce7b96a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/07/25 23:00, Marc-André Lureau wrote:
> Negative values should be return for errors.

Nit: s/return/returned/

> 
> It also helps with GCC false-positives:
> ../block/blkio.c: In function ‘blkio_co_getlength’:
> ../block/blkio.c:943:8: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
>    943 |     if (ret < 0) {
>        |        ^
> 
> Fixes: fd66dbd424 ("blkio: add libblkio block driver")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   block/blkio.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blkio.c b/block/blkio.c
> index fb8bec27d71a..d2ba2a4d58dc 100644
> --- a/block/blkio.c
> +++ b/block/blkio.c
> @@ -935,13 +935,13 @@ static int64_t coroutine_fn blkio_co_getlength(BlockDriverState *bs)
>   {
>       BDRVBlkioState *s = bs->opaque;
>       uint64_t capacity;
> -    int ret;
> +    int ret = -1;

Initializing a variable with a dummy value can suppress a useful 
warning. Replacing WITH_QEMU_LOCK_GUARD() with QEMU_LOCK_GUARD() will 
fix it without introducing a dummy value and also result in a bit 
simpler code.

Regards,
Akihiko Odaki

>   
>       WITH_QEMU_LOCK_GUARD(&s->blkio_lock) {
>           ret = blkio_get_uint64(s->blkio, "capacity", &capacity);
>       }
>       if (ret < 0) {
> -        return -ret;
> +        return ret;
>       }
>   
>       return capacity;
> 

