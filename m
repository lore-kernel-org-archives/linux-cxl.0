Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B56F374E5B
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 04:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785127254; cv=none; b=ACvGf/E9oZjlN/vV7jaSwyLcJ31k92CB4pctedsiaHnAe3bWLKmP/lecUsudxIbFxv5QaYrTgPWJWoPso75w+bfzvoDZaFMxY0qEGpNQqLZo5B1q3d3t3cH5dHaqipmHnRW30uxYO1+hyPcjUoE/SEprPF2wu4LJ0vBM1sztkX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785127254; c=relaxed/simple;
	bh=UO02C9z2tic/Qo/soNLkAjKqGKFiAg19sgKkt/O4hTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hJOcWs0NPGO6aDrFL6rf5xTcUGjOrtEhJ9iFTIiBDWCK3vf+9mEscX3N8XEV+GzT2vOLjqRPuu/t9vE3ClUQsgxt9x68OdcLVrVYJB50jH+wsesJs/RrzGXS4fCz1UQf9srE+Wc0hB6rUxgQ2t4GUjNIqqYcGP4EviHDoxSO2O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=jWs6yonO; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="jWs6yonO"
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66R4emMA047169
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 27 Jul 2026 13:40:48 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=P+n2yqHAEB0fjUEbDZnBYZx+mrptb5uxVUai3KjbmFE=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250326; t=1785127249; v=1;
        b=jWs6yonOxfPbIhMbYHVnuGXwNjRQ9IqlE6c3Dvt1RLbedYcO4UbMKkx8Io8gqnmW
         tz3lVexA0oI5/0nyL66+yk436BwN91514TRY2GdFQ8b4pre+KfenWUDVgwHuLUwU
         vf29CMT/0j+0Yk4iKSIL0s0WiZjQqNEX7MRGjAWms44hXIV6nYs8lUcRzNjpVRjD
         20BR9+RVtrkEdgBDEzqkEmeo3+A2MfpRzjuEWs2CLraYT0wP0LrKPHh8LbujfW6S
         jAe7XYJzuLjdpX1qtYl0ToPi03WTAHSHP822MsT0IsS9geXpx8M1NnWYUv74/+W/
         CFBrLZwLC0RZxqhJYIE3Iw==
Message-ID: <70e1a2db-472d-46f4-ae27-ea8fb4af6cc0@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 27 Jul 2026 13:40:48 +0900
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] hw/cxl: fix invalid free on early return
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
        =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
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
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-5-d0c4831ed7ea@redhat.com>
 <20260726164738-mutt-send-email-mst@kernel.org>
 <CAJ+F1C+fCyazpGfof9H0_n54FMy3LX6ujdmTcW=gAmhFz8Lk-w@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAJ+F1C+fCyazpGfof9H0_n54FMy3LX6ujdmTcW=gAmhFz8Lk-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/07/27 6:09, Marc-André Lureau wrote:
> On Mon, Jul 27, 2026 at 12:49 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Mon, Jul 27, 2026 at 12:44:04AM +0400, Marc-André Lureau wrote:
>>> Fixes: 680935c9a6ff ("hw/cxl: Add a performant (and correct) path for the non interleaved cases")
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> Not commit log really?
> 
> SSIA, but I can make it longer if it helps.

I agree the subject is sufficient so:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

That said, we can quote docs/devel/style.rst if desired:

 > * Variables declared with g_auto* MUST always be initialized,
 >   otherwise the cleanup function will use uninitialized stack memory

Regards,
Akihiko Odaki

> 
>>
>>> ---
>>>   hw/cxl/cxl-host.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
>>> index 7e744312f1d8..eba13c9e7cba 100644
>>> --- a/hw/cxl/cxl-host.c
>>> +++ b/hw/cxl/cxl-host.c
>>> @@ -279,7 +279,7 @@ static void cxl_fmws_direct_passthrough_setup(CXLDirectPTState *state,
>>>       MemoryRegion *mr = NULL;
>>>       uint64_t vmr_size = 0, pmr_size = 0, offset = 0;
>>>       MemoryRegion *direct_mr;
>>> -    g_autofree char *direct_mr_name;
>>> +    g_autofree char *direct_mr_name = NULL;
>>>       unsigned int idx = state->hdm_decoder_idx;
>>>
>>>       if (ct3d->hostvmem) {
>>>
>>> --
>>> 2.55.0
>>
>>

