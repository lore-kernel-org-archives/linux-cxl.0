Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22324377A94
	for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 08:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785054800; cv=none; b=hFawOPw+6e5/4dfvl8SY4f+aHf343hiEtEr/yEPjSkSw1EnvEIOVYUtBQkWIX8PNS35JukxOqign/OcWwk1Ov3RHnEaUGU7iflTwv3xs1e/C3sQflQ0Sv7xOxJhOuTKL2UwTMVCjiuXVa7vjr2wic6Jbgsh1MLn45woc2m//j6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785054800; c=relaxed/simple;
	bh=ivWYINC62v6vFdOHlxT198A3VxD1tpgFUiSCnsyXCO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjlETTPWFBGdMsEhYoAKwJkXIhicULSOe/OqCqiVCMtinUS61Na8qN6yuDyRniry5ZFj0Tr6wfrJYrf0HGzxIoXBJ7g/UtN1YJiU52HR0CKS238giOvxB7DucG3y9LeRpDrT7W/RGcTsRrtI2ERxyV5gByI0tW/0sD4TZp918HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=AdJzZ7o9; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="AdJzZ7o9"
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66Q8XF4R034902
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 26 Jul 2026 17:33:15 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=QswiQ/L8FXd+V4Ti1ALLVF/K+0AewuQNXXBx9a9d7BI=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250326; t=1785054795; v=1;
        b=AdJzZ7o9rJUuo/1AtWXo8kIXJwsajUsD17j9Lw6FK3XcUk/rK2HacQ7TAgVfHZNJ
         NgZvrSnEdBOflt8wEO5WDcQJbJWackyYLHS0bxwXr7w2JkQDiUvW9hQ1doOl03eI
         kdzRMOMeprGsoFL2/ZPrFWZKmeYUS5vLjSyXlI7Mvr+ewxDdXXAotFcKrsBNAARi
         i2znZzTaWffwr+flCmth72YCbym21kgtEv/y4yzTkzYB7xspqNDC7SLBiH4T5bBw
         IQDozdAGfBWvJ8xWpub2+qA3YbXZJXJ1bsXhUZE+vCwAv9bK+xmW+y5GBOuoya31
         QrLRPsrHRKIxCydMpZ5kjA==
Message-ID: <6ea16c39-3bae-4ea7-8e91-afb58f775ca2@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 26 Jul 2026 17:33:15 +0900
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] hw/display/virtio-gpu-rutabaga: zero-init capset info
 response
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        "P. Berrange, Daniel" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
        Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
        Jonathan Cameron <jic23@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
        Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
        Phil Dennis-Jordan
 <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
        linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
        Haotian Jiang <jianghaotian.sunday@gmail.com>
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
 <20260725-fix2-v1-1-5c9a6ce7b96a@redhat.com>
 <d6876e8f-1414-4e7d-b6e2-1b59a18e8288@rsg.ci.i.u-tokyo.ac.jp>
 <CAMxuvawR=TiF4r+wdVCDF3Hyu-ND9neFHjUEZn5_YnSbxweXhg@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <CAMxuvawR=TiF4r+wdVCDF3Hyu-ND9neFHjUEZn5_YnSbxweXhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/07/26 17:24, Marc-André Lureau wrote:
> Hi
> 
> On Sun, Jul 26, 2026 at 11:33 AM Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> On 2026/07/25 23:00, Marc-André Lureau wrote:
>>> rutabaga_cmd_get_capset_info() only fills in capset_id,
>>> capset_max_version and capset_max_size before sending the response to
>>> the guest. The remaining fields of struct virtio_gpu_resp_capset_info,
>>> including hdr.fence_id, hdr.ctx_id and hdr.ring_idx, are left with
>>> stack garbage and leaked to the guest, including host pointers useful
>>> for an ASLR bypass.
>>>
>>> Zero the response first, matching virgl_cmd_get_capset_info().
>>>
>>> Not a real risk thanks to -ftrivial-auto-var-init=zero.
>>
>> GCC only added -ftrivial-auto-var-init=zero in GCC 12, while QEMU still
>> supports GCC 10.4/11.
>>
> 
> Good point, may be we should update:
> https://patchew.org/QEMU/20260723094622.1515831-1-berrange@redhat.com/
> 
> ack otherwise?

Yes:

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards.
Akihiko Odaki

> 
>> Regards,
>> Akihiko Odaki
>>
>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3609
>>> Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
>>> Reported-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    hw/display/virtio-gpu-rutabaga.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
>>> index 4d7d7b245929..95a19eed7eda 100644
>>> --- a/hw/display/virtio-gpu-rutabaga.c
>>> +++ b/hw/display/virtio-gpu-rutabaga.c
>>> @@ -555,6 +555,8 @@ rutabaga_cmd_get_capset_info(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
>>>
>>>        VIRTIO_GPU_FILL_CMD(info);
>>>
>>> +    memset(&resp, 0, sizeof(resp));
>>> +
>>>        result = rutabaga_get_capset_info(vr->rutabaga, info.capset_index,
>>>                                          &resp.capset_id, &resp.capset_max_version,
>>>                                          &resp.capset_max_size);
>>>
>>
> 

