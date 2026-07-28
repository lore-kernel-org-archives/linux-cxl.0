Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651C23BB117
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jul 2026 06:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785221163; cv=none; b=jH///iPojpi1/dgyXBK5l/uR01i22Th5/rFzo4KhbKnCUoAj2bp5MG1sKEUS30MQLS+zbOwQGLEcKyvAKn7LPtJj+Clp/FlA9WTAYpBntD9PndjykDEM2K5IOKUCsu2GL8Xl9MuADarLbFVV5MRNsojGSHpKd11mUQebyKMzLI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785221163; c=relaxed/simple;
	bh=3jAz7lEmLIc+uRAHM+D/1s8Z6iEiSGaSs+zkltFlaWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fCtUnjuWZKQWMaGNQmc8iGVNtLNuZipOMiEufsqZLjNvWEZYmulE3YPEfiACOwlf3NH2/HZYzv8aCuZWGa0EPVcXjorjBZrU91gztaRA9Xfq2yJeYeDNBjeuEYbMWbqz1cLbldGPYkpednNlGKKb17yoVVKfJfrxqEdx3e+ngz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=dzGBbr7Q; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="dzGBbr7Q"
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66S6jxUp022470
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 28 Jul 2026 15:45:59 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=F4Kpp8ZC+oShbz+ryerAbTbGLQGu+Iok9aKAPBtTJDM=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250326; t=1785221159; v=1;
        b=dzGBbr7Q3KYLWAzNTFDlVI/reG15Zttb9//6Atkehu0E6/Glvd41W+ZczxfofFDz
         28BNu2A24X8Hs6y00FAc7vvRbBliRLGod9NkIBprRvK5S6TG4OtB/z3yHk34wxC2
         NjJi1cddUtFu72Om9mZfJotdVbhgVQf/lyfyWhw6GQPwVnbEpxSOdnV/ylOoTwYk
         Z/PSDfu52STuUMN7OqxXxt+RNiu5WhV5nv6/3905loi8hmHQQFDb0I+VguvOHhX+
         yY7tnHytFdOcysA2nuz8mduoX7/KJDdzRl/NYJPyK6VhEDs5pWKQ3ZZCpQ/nw9RC
         J1O2ls5w5lsUlx0s8o3SfQ==
Message-ID: <cdba4688-2aa5-42a1-8dcc-f540989314ee@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 28 Jul 2026 15:45:58 +0900
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] hw/cxl: fix invalid free on early return
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        qemu-devel@nongnu.org,
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
 <70e1a2db-472d-46f4-ae27-ea8fb4af6cc0@rsg.ci.i.u-tokyo.ac.jp>
 <20260727042804-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260727042804-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/07/27 17:30, Michael S. Tsirkin wrote:
> On Mon, Jul 27, 2026 at 01:40:48PM +0900, Akihiko Odaki wrote:
>> On 2026/07/27 6:09, Marc-André Lureau wrote:
>>> On Mon, Jul 27, 2026 at 12:49 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>
>>>> On Mon, Jul 27, 2026 at 12:44:04AM +0400, Marc-André Lureau wrote:
>>>>> Fixes: 680935c9a6ff ("hw/cxl: Add a performant (and correct) path for the non interleaved cases")
>>>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>
>>>> Not commit log really?
>>>
>>> SSIA, but I can make it longer if it helps.
>>
>> I agree the subject is sufficient so:
>>
>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>
>> That said, we can quote docs/devel/style.rst if desired:
>>
>>> * Variables declared with g_auto* MUST always be initialized,
>>>    otherwise the cleanup function will use uninitialized stack memory
> 
> I like that. But the question is not just whether it's required by
> the coding style. The question is if there's a bug and how is it
> reacheable, which can guide things like backporting decisions.
> Thanks!

The quoted text also tells the consequence. Probably it's placed in 
docs/devel/style.rst just because people are likely to check it.

Regards,
Akihiko Odaki

> 
>> Regards,
>> Akihiko Odaki
>>
>>>
>>>>
>>>>> ---
>>>>>    hw/cxl/cxl-host.c | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
>>>>> index 7e744312f1d8..eba13c9e7cba 100644
>>>>> --- a/hw/cxl/cxl-host.c
>>>>> +++ b/hw/cxl/cxl-host.c
>>>>> @@ -279,7 +279,7 @@ static void cxl_fmws_direct_passthrough_setup(CXLDirectPTState *state,
>>>>>        MemoryRegion *mr = NULL;
>>>>>        uint64_t vmr_size = 0, pmr_size = 0, offset = 0;
>>>>>        MemoryRegion *direct_mr;
>>>>> -    g_autofree char *direct_mr_name;
>>>>> +    g_autofree char *direct_mr_name = NULL;
>>>>>        unsigned int idx = state->hdm_decoder_idx;
>>>>>
>>>>>        if (ct3d->hostvmem) {
>>>>>
>>>>> --
>>>>> 2.55.0
>>>>
>>>>
> 

