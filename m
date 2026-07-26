Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D793337A827
	for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 07:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785051170; cv=none; b=UKiVbaBNPpjaW9TGIYgs74Euzm5JjHZOCCspqSE/R4weLAxjTXKz1VEJ+GZxZWc6LMME7nsCYtwKp0MMspQP0y5IiYaHbENoGTOgixdFjzFQNSOyxs+blEFfeaehxdFhJ/XGdiG9fqmWvLBd8UyP6zkvxXgbwVmpArbCAR1POq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785051170; c=relaxed/simple;
	bh=+5xamrbJsE2fO/pqbCl4xfJ7Ud6rEYZr9rb6gAvjL6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qR3OhjH4iqG1KbmT6/OGQkPJEvLRM57DD0Xj/lNWLeyX3wDJNkuFk+SoNRRSbZ/dLGF/qvfLAtrRYgSS7tZcmbauxbbWKY59DtjkgfKrtll9TgPXGPmCgR4OSKSUvmwwsHS2/gbX+tdUgyusOXXBuZx9XtxD+4Lq/sIwZ1ClFws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=LWe123BD; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="LWe123BD"
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66Q7Wjjs016113
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 26 Jul 2026 16:32:45 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=vIofFsoyURhNA1xn0QrxmHss0QCY0T4BKkVOkaOe3uo=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250326; t=1785051165; v=1;
        b=LWe123BDaG/IJJl2sHUYhjHav6u0qlYh8SyUsdiK24eD/i4z+W1F6CMHNYQYOe7l
         n1e6J+vNUqi7dxL4itj+K69fGYyModMEqTpjntkzp9KsehbYVpzuCmuSGgebE+2c
         8tG0noWdNbZwnNdjawc3rUIkSlWUgwl9FW7d391isi5BwcVxFw2W8OvaB01Bh9uX
         t945BdnvaX9PlYRK33LzqLJ0JVlQE5YJhpTygIgakSehIXb4yMHyxRNy9gRW/nxQ
         hzl0116RsE1Vmnkqrsd58W00y7OnChc/WNpztgoPle7LhsrNzd8wS7F4a0+IFlYt
         aBb5CGeudMKYAFoIqZe7ow==
Message-ID: <d6876e8f-1414-4e7d-b6e2-1b59a18e8288@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 26 Jul 2026 16:32:45 +0900
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
        Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
        Haotian Jiang <jianghaotian.sunday@gmail.com>
References: <20260725-fix2-v1-0-5c9a6ce7b96a@redhat.com>
 <20260725-fix2-v1-1-5c9a6ce7b96a@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260725-fix2-v1-1-5c9a6ce7b96a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/07/25 23:00, Marc-André Lureau wrote:
> rutabaga_cmd_get_capset_info() only fills in capset_id,
> capset_max_version and capset_max_size before sending the response to
> the guest. The remaining fields of struct virtio_gpu_resp_capset_info,
> including hdr.fence_id, hdr.ctx_id and hdr.ring_idx, are left with
> stack garbage and leaked to the guest, including host pointers useful
> for an ASLR bypass.
> 
> Zero the response first, matching virgl_cmd_get_capset_info().
> 
> Not a real risk thanks to -ftrivial-auto-var-init=zero.

GCC only added -ftrivial-auto-var-init=zero in GCC 12, while QEMU still 
supports GCC 10.4/11.

Regards,
Akihiko Odaki

> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3609
> Fixes: 1dcc6adbc168 ("gfxstream + rutabaga: add initial support for gfxstream")
> Reported-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/virtio-gpu-rutabaga.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
> index 4d7d7b245929..95a19eed7eda 100644
> --- a/hw/display/virtio-gpu-rutabaga.c
> +++ b/hw/display/virtio-gpu-rutabaga.c
> @@ -555,6 +555,8 @@ rutabaga_cmd_get_capset_info(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
>   
>       VIRTIO_GPU_FILL_CMD(info);
>   
> +    memset(&resp, 0, sizeof(resp));
> +
>       result = rutabaga_get_capset_info(vr->rutabaga, info.capset_index,
>                                         &resp.capset_id, &resp.capset_max_version,
>                                         &resp.capset_max_size);
> 

