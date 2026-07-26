Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5319353A6B
	for <linux-cxl@vger.kernel.org>; Sun, 26 Jul 2026 08:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785056095; cv=none; b=TnWIoGXTp/f7fdPSEQXc4uIr7rW3LjRSxlm8946KB9qWIYU8pqyJNt27jHVabCyP+CEdjgbKPvY715zvlVJM4oGBzKXV554vgvnKiFeu6Hp0X2flG9BDCIG4N2ukIJAawPOI3PxiEZU9360Fs0gQYJrqouUi4quToQc6yPhZ76M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785056095; c=relaxed/simple;
	bh=dEJeHOz60lto/Q29TuBaBGpt8Q2QKDW+lvwgf3/mAVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ExiyatYG4THZXYOcds56M6Zp3w0Jz4gb4P5V6WebkRfatbUMvyQYa475+R4+puP9AUBDpRTQxR9JWMU8ard6HxLe6xdZmZ2p5+NMFuyuOeg9Wqib2si+K3g+r9WVjNk6jT3asrRpyynWyKqKU1+ieqeo3OH4D/obtTVd/syv27g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=tdXf8xzT; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="tdXf8xzT"
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66Q8spD6041554
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 26 Jul 2026 17:54:51 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=zLiyvFbK0EZfPQhzcGaxWTV73bEQVJG8/gJeaWqLKas=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250326; t=1785056091; v=1;
        b=tdXf8xzTF4jl9mgPvb+xLc5UE+wFmGPZQKm1LIbowW7Ot/9MY3LCFVFQDCPgRCSR
         k8sGdP5gIf75509VfKMEW/UZZTp00rXCJcMOan6+s49TkvWgA1XGDzCBbvanzAwB
         Qp/swMScHMfGfZiOXBb7tXJp7pXq6B3ZkbdzwmL1S9nHqwTpcC9sHxI7hiG/ygKH
         IfyNH86QCFkSFsH2qTI37F4nRtNdsn/1My1lntFWKjw4mbLvtnzT7rlPiywo1NCG
         OkfNN5cYC7CmWVLvZc7MBCNETeXnRTc20MIv8xvYLw6ItY2FaEypQjFOL7XQlqxr
         oqXK4ATth/GUc4kBAYu48Q==
Message-ID: <e982d318-965f-4f0f-a709-37808e1149ca@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 26 Jul 2026 17:54:50 +0900
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] hw/core/machine: free machine->fdt in
 machine_finalize()
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
 <20260725-fix2-v1-5-5c9a6ce7b96a@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260725-fix2-v1-5-5c9a6ce7b96a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/07/25 23:00, Marc-André Lureau wrote:
> machine->fdt is a plain g_malloc0() buffer (see create_device_tree())
> that boards populate during MachineClass::init, but machine_finalize()
> never freed it, unlike the other boot-time buffers (dtb, dumpdtb,
> kernel_filename, ...). Free it for consistency.

This unfortunately converts an existing bug into double-free.

spapr_machine_reset() aliases machine->fdt to spapr->fdt_blob. 
spapr_dtb_pre_load() and h_update_dt() later free it via
spapr->fdt_blob, but does not update machine->fdt, making it dangling.

Leaving machine->fdt dangling is already a bug. 
do_client_architecture_support() explains that as follows:

     /*
      * Set the machine->fdt pointer again since we just freed
      * it above (by freeing spapr->fdt_blob). We set this
      * pointer to enable support for the 'dumpdtb' QMP/HMP
      * command.
      */
     MACHINE(spapr)->fdt = fdt;

This patch introduces another path to trigger the bug.

Regards,
Akihiko Odaki

> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/core/machine.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 805148678d57..2b24d711d76f 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -1301,6 +1301,7 @@ static void machine_finalize(Object *obj)
>       g_free(ms->kernel_cmdline);
>       g_free(ms->dtb);
>       g_free(ms->dumpdtb);
> +    g_free(ms->fdt);
>       g_free(ms->dt_compatible);
>       g_free(ms->firmware);
>       g_free(ms->device_memory);
> 

