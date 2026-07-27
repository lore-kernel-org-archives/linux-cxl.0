Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C2A233723
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 05:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785129944; cv=none; b=Qot41M/xgmJRh6dmn4zixwKHQHCfyMj8NBoK/RcEutdgGZW2aL1y1+kQxxX0W/hE8X8ErSBLMvQxmKS7vFjiPvWy4bulBEuI6CmKYXcBIPE7FKG+x4bkJ8fSJ3e7n4aXe9Bj1kw6jync8MGZCyUoaX09XAuerRgaVpugmwUvB0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785129944; c=relaxed/simple;
	bh=VKhZFP1MeWMBGeskHT2D3ONDmW759eOxSpBV/GFZiyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MChx/gytqLdx2eBHwxDvRwDV+x/CVUUxk+teWgCpEDQQhQZZELsCeElyrQc3TDN8e2RwfA/sATCbVaknNbwYwQd58rUuasHyP6Oo2FCymvsDk0KkjrvQGYw4aDDeZHMZ0bpH1KoOssSFlHsti2C9Qi0KUx8smHW0Pn+Xi0h0+dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=rbx1ddXb; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="rbx1ddXb"
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66R5Pdqa066629
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 27 Jul 2026 14:25:39 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=GGa6R38NbVnwvhp0grawB8YYYRdUfsmOs9cyar+VFaE=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250326; t=1785129940; v=1;
        b=rbx1ddXbGRRZE2SNGmdPCWzGiOZ+rMoG1+xpTPbqkUangaPxfhO6hQVsqVvt3Hcl
         xh3I8LY/J642FKUU3PmxrlaFwHjN5qtGtenUjgP6P6HTYfYKxU+s+JfFE5SGAXuB
         FX5Bt+Af/FiH9pPPdjHfQ1ZyPdkTvoDyboUJ155lQJBQAXw12m1fXXMtEArcNWR6
         +4c6ha9hya2wdfsVmSSyN5+JmypvU0nMncB2mpvt+tTn0nLm1B15DfCx2U59fg0C
         Qyo4T5LDow7Aqr6ee6cj4jA3BziVPV9+yQwA4Pd2dzdtXL4GKDmxNkoSjh15EdXr
         87AYh//rXaQAXH3TdbaPbQ==
Message-ID: <d9c4321c-ed39-4da6-926b-bae4b1491a52@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 27 Jul 2026 14:25:39 +0900
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/12] Fix some -Werror=maybe-uninitialized
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
 <20260727-fix2-v2-7-d0c4831ed7ea@redhat.com>
 <20260726165049-mutt-send-email-mst@kernel.org>
 <CAJ+F1C+jzxfbWbmLoU6vMobKUr0VFkpnr--FyPcy8o1=Q0vY-g@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAJ+F1C+jzxfbWbmLoU6vMobKUr0VFkpnr--FyPcy8o1=Q0vY-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/07/27 6:07, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Jul 27, 2026 at 12:53 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Mon, Jul 27, 2026 at 12:44:06AM +0400, Marc-André Lureau wrote:
>>> When compiled with -Og, gcc produces many false-positives
>>> gcc (GCC) 16.1.1 20260515 (Red Hat 16.1.1-2).
>>
>> it hurts if you do it? so don't do it then?
> 
> We are not far from getting it working, we can accommodate a bit of
> code while making it a bit clearer for the reader too.
> 
>>
>>> We already use auto-var-init=zero, but better be explicit.
>>
>> explicit about false positives?
> 
> Explicit initialization

These are the same concerns I raised in my previous review:

https://lore.kernel.org/qemu-devel/f919e684-93ed-4eca-8ddc-785e69dd8add@rsg.ci.i.u-tokyo.ac.jp/

I do not think this patch make the code clearer. They add values that 
are never consumed, which obscures rather than clarifies the data flow. 
Leaving a variable uninitialized until its actual value is assigned 
makes that flow more explicit.

Still, I think this change makes sense. Failure with -Og shows that
whether GCC emits the warning depends on subtle optimization details.
Avoiding that dependency is worthwhile.

> 
>>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>   target/i386/cpu.c             | 3 ++-
>>>   target/i386/emulate/x86_mmu.c | 4 ++--
>>>   2 files changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>>> index 5805d33ab92d..28e4435df23f 100644
>>> --- a/target/i386/cpu.c
>>> +++ b/target/i386/cpu.c
>>> @@ -7734,7 +7734,7 @@ static void x86_cpuid_get_avx10_version(Object *obj, Visitor *v,
>>>   static bool x86_cpu_apply_avx10_features(X86CPU *cpu, uint8_t version,
>>>                                            Error **errp)
>>>   {
>>> -    const AVX10VersionDefinition *def;
>>> +    const AVX10VersionDefinition *def = NULL;
>>>       CPUX86State *env = &cpu->env;
>>>
>>>       if (!version) {
>>> @@ -7757,6 +7757,7 @@ static bool x86_cpu_apply_avx10_features(X86CPU *cpu, uint8_t version,
>>>               break;
>>>           }
>>>       }
>>> +    assert(def != NULL);
>>>
>>>       if (def->version < version) {
>>>           error_setg(errp, "avx10-version can be at most %d", def->version);
>>
>>
>> what does assert have to do with gcc warnings?
> 
> That's what is expected at this point, unfortunately the compiler
> doesn't care we help it here. I can drop it

I would keep it. It reduces the downside of introducing an otherwise 
unused initial value by documenting the invariant.

> 
>>> diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
>>> index 8d4371467fd7..65bcccd4751e 100644
>>> --- a/target/i386/emulate/x86_mmu.c
>>> +++ b/target/i386/emulate/x86_mmu.c
>>> @@ -185,8 +185,8 @@ static MMUTranslateResult walk_gpt(CPUState *cpu, target_ulong addr, MMUTranslat
>>>       int largeness = 0;
>>>       target_ulong cr3 = x86_read_cr(cpu, 3);
>>>       uint64_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK;
>>> -    MMUTranslateResult res;
>>> -
>>> +    MMUTranslateResult res = MMU_TRANSLATE_PAGE_NOT_MAPPED;
>>> +
>>
>>
>> This is not 0 as the commit log implies.
> 
> Initializing with 0 implies defaulting to MMU_TRANSLATE_SUCCESS - not
> the best choice here.

Since the value is ultimately overwritten anyway, the specific 
placeholder chosen doesn't strictly matter for execution, but 
MMU_TRANSLATE_SUCCESS feels like a more natural default behavior.

walk_gpt() checks each page-table level until one rejects the mapping or
all levels have been traversed. If top_level == 0 (i.e., there is zero 
levels to traverse), nothing would have rejected the mapping, so success 
is more natural than MMU_TRANSLATE_PAGE_NOT_MAPPED.

Regards,
Akihiko Odaki
