Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9402798EC
	for <linux-cxl@vger.kernel.org>; Tue,  1 Jul 2025 15:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751384849; cv=none; b=P7s8PAY4lVdUqQPO7pQwDD2oJfVofutOe0bN4Xdb9LxiRctZ8JuG8zIP9B+H9LoHgQGrb2D3DPuiAsWF7cTa+ggncMgABuigYo1Go7Majz+s28DRIKJQ7CIQd77GECutxMqYwIfJUC2gaLbBtJGrLRN+xKbOVZ+ow4+dvESwFc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751384849; c=relaxed/simple;
	bh=nHir57VvmF0U8VEMxyTq6ix0SlBu0aK/TMEfCLovA8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XREjfIqaQTk/s8kBcf8/jRkP1k5Q8jFgnCugz6//jNbgyPWO5Ud11O/gXYi8ZoYDozREUihu1GXyxbisaBA3Y1jtdjPMjIn3peBrkhABc+wihSNdoy7LODDvPRLDTEObHRDGHy1/JRrujArP4h+FVbbX7/YgIhnqdFBFI52Ztt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eNOmHv5Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNOmHv5Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751384846;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k3wxbJ6u0LbCPii/UzJiKDKg2FWqqu/s9vaGG/5Susc=;
	b=eNOmHv5YkipAimd2nhQSp66pQDbZRpqo6y/IgC/sP1X5QBnMNYp2Y5JTq3nqu8ALqOCJgb
	rSWuBNX/n6TjeJ/OKkEs50Yy1Co3nt7D4iKZLMaNVuaSwFYas7VnFAr86WER2A6um7CmjY
	JENJILQ1DIkp4ROpmIHeWaIbeu+r2Ew=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-0GSwpY6qPjmOhDCp9KH32w-1; Tue, 01 Jul 2025 11:47:25 -0400
X-MC-Unique: 0GSwpY6qPjmOhDCp9KH32w-1
X-Mimecast-MFC-AGG-ID: 0GSwpY6qPjmOhDCp9KH32w_1751384844
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4537f56ab74so24290605e9.3
        for <linux-cxl@vger.kernel.org>; Tue, 01 Jul 2025 08:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751384844; x=1751989644;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3wxbJ6u0LbCPii/UzJiKDKg2FWqqu/s9vaGG/5Susc=;
        b=pVLdgVsJ3qoCC5L7kE1Rifz4TU45VgJCk4Cnud9OWC8WtS0hj1B4fMnkc8TdOhk9tw
         bhJmiQLtmUe0Wdz+Ehxfm0amgJt4rLg8gaVQfFri2//TwRe37SrWSeB0QV6gr1ScMcED
         wIkJ/YNPt9dwS8FdDu8yMurdmR0LDZw48CK7HizF+502AHVW/Q2m8sDL5v03hdPE9OhS
         xar/ZFQUF9moWpBpgrFzqqzP4r/goyraexnZbe6DHh3CFaCSwzBqbwbpwpymDJD/CQlI
         WnYvhGHdaoFQrvZ3/bOb3YEidekUW3xlmm0iufSwcj2/QzjscFK72HHfrMgWLyDk1HE+
         jWvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoUgMrGT4sR26KHy+2RKVS+PE2DcXvuspvE9palbnkPGMNDMRSChNrV1t2Azt2OTAsSC3mY1il46M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiPhE4b/nCqNflOUryCEdFRdXEsiZbcy403Erjsh9nyMtjIpDc
	Rw6Rn1JSe//zrfbwrzt3uXf3SOdLfhMmgZXZX5/JIkg9F7vidXPZuMyNmLbF0pJhWSLj7sk8TN5
	aMQzJ8B+94gVX+rYPqko5/NDRPz9Y57qCRvOY2lp07qzsplbrMWTjDZvx+06g5Q==
X-Gm-Gg: ASbGnct5rgllhfPlSlY69m716SiKLMb5Gdoslpa4ag/zOiDdDsEJtxGTaop5nUlIeVn
	VesfNI68o6bSIHia/WgQu62CR1P7rquAnnmP274Q61foSr6jXyvKpsh0FEKTLIhZ/LUOyfkO1Bb
	gRsbY4cjyzw0XEVRgqAi/wK3YAmWPqjq1oGPMRSg80aop4UYknEIpTv+Dh40Hmc8ZM4gr+5P0z6
	MX4/Oa3GGYdi118A9PeDuln40ZLKbIdlR30DEmbyrSgoqs8nW5W/DJ6qJrNwuuqeUTU73TKxIs3
	DgxTR69Fx5YMuD+6QiIQ2k9W8XVKrqi8xz8sGXsPrhWuOeI7fekGO0GcQea1K/W0tQz8Fg==
X-Received: by 2002:a05:600c:c4a7:b0:43c:ea1a:720a with SMTP id 5b1f17b1804b1-45391b6b961mr155578245e9.1.1751384843632;
        Tue, 01 Jul 2025 08:47:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUlW/iYyEMISr2wG82jHg+cr6qo8A5+AAh5UTTei64Zk2bZgbhU1lubsjcDM47l8/A3nww1Q==
X-Received: by 2002:a05:600c:c4a7:b0:43c:ea1a:720a with SMTP id 5b1f17b1804b1-45391b6b961mr155577905e9.1.1751384843132;
        Tue, 01 Jul 2025 08:47:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c1easm198152655e9.3.2025.07.01.08.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 08:47:22 -0700 (PDT)
Message-ID: <30f089df-c521-49c7-ad1f-f4663de4958f@redhat.com>
Date: Tue, 1 Jul 2025 17:47:21 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH qemu v16 5/5] qtest/cxl: Add aarch64 virt test for CXL
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Fan Ni <fan.ni@samsung.com>, Peter Maydell <peter.maydell@linaro.org>,
 mst@redhat.com, Zhijian Li <lizhijian@fujitsu.com>,
 Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: linuxarm@huawei.com, linux-cxl@vger.kernel.org, qemu-arm@nongnu.org,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250625161926.549812-1-Jonathan.Cameron@huawei.com>
 <20250625161926.549812-6-Jonathan.Cameron@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250625161926.549812-6-Jonathan.Cameron@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vSYmnTTctg9gullaGHNBnsN_vtiFlMbWrbL5tVNa7xE_1751384844
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/25/25 6:19 PM, Jonathan Cameron via wrote:
> Add a single complex case for aarch64 virt machine.
> Given existing much more comprehensive tests for x86 cover the
> common functionality, a single test should be enough to verify
> that the aarch64 part continue to work.
nit: continues
>
> Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
>
> ---
> v16: Update to bring improvements made to other tests (Peter Maydell).
>      I'd failed to notice when rebasing this over time that the
>      other tests had undergone various improvment and I should have
>      updated this one as well.
> ---
>  tests/qtest/cxl-test.c  | 58 ++++++++++++++++++++++++++++++++---------
>  tests/qtest/meson.build |  1 +
>  2 files changed, 46 insertions(+), 13 deletions(-)
>
> diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
> index a600331843..8fb7e58d4f 100644
> --- a/tests/qtest/cxl-test.c
> +++ b/tests/qtest/cxl-test.c
> @@ -19,6 +19,12 @@
>      "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
>      "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
>  
> +#define QEMU_VIRT_2PXB_CMD \
> +    "-machine virt,cxl=on -cpu max " \
> +    "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
> +    "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
> +    "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
> +
>  #define QEMU_RP \
>      "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 "
>  
> @@ -197,25 +203,51 @@ static void cxl_2pxb_4rp_4t3d(void)
>      qtest_end();
>      rmdir(tmpfs);
>  }
> +
> +static void cxl_virt_2pxb_4rp_4t3d(void)
> +{
> +    g_autoptr(GString) cmdline = g_string_new(NULL);
> +    g_autofree const char *tmpfs = NULL;
> +
> +    tmpfs = g_dir_make_tmp("cxl-test-XXXXXX", NULL);
> +
> +    g_string_printf(cmdline, QEMU_VIRT_2PXB_CMD QEMU_4RP QEMU_4T3D,
> +                    tmpfs, tmpfs, tmpfs, tmpfs, tmpfs, tmpfs,
> +                    tmpfs, tmpfs);
> +
> +    qtest_start(cmdline->str);
> +    qtest_end();
> +    rmdir(tmpfs);
> +}
>  #endif /* CONFIG_POSIX */
>  
>  int main(int argc, char **argv)
>  {
> -    g_test_init(&argc, &argv, NULL);
> +    const char *arch = qtest_get_arch();
>  
> -    qtest_add_func("/pci/cxl/basic_hostbridge", cxl_basic_hb);
> -    qtest_add_func("/pci/cxl/basic_pxb", cxl_basic_pxb);
> -    qtest_add_func("/pci/cxl/pxb_with_window", cxl_pxb_with_window);
> -    qtest_add_func("/pci/cxl/pxb_x2_with_window", cxl_2pxb_with_window);
> -    qtest_add_func("/pci/cxl/rp", cxl_root_port);
> -    qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
> +    g_test_init(&argc, &argv, NULL);
> +    if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
> +        qtest_add_func("/pci/cxl/basic_hostbridge", cxl_basic_hb);
> +        qtest_add_func("/pci/cxl/basic_pxb", cxl_basic_pxb);
> +        qtest_add_func("/pci/cxl/pxb_with_window", cxl_pxb_with_window);
> +        qtest_add_func("/pci/cxl/pxb_x2_with_window", cxl_2pxb_with_window);
> +        qtest_add_func("/pci/cxl/rp", cxl_root_port);
> +        qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
>  #ifdef CONFIG_POSIX
> -    qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
> -    qtest_add_func("/pci/cxl/type3_device_pmem", cxl_t3d_persistent);
> -    qtest_add_func("/pci/cxl/type3_device_vmem", cxl_t3d_volatile);
> -    qtest_add_func("/pci/cxl/type3_device_vmem_lsa", cxl_t3d_volatile_lsa);
> -    qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
> -    qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4", cxl_2pxb_4rp_4t3d);
> +        qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
> +        qtest_add_func("/pci/cxl/type3_device_pmem", cxl_t3d_persistent);
> +        qtest_add_func("/pci/cxl/type3_device_vmem", cxl_t3d_volatile);
> +        qtest_add_func("/pci/cxl/type3_device_vmem_lsa", cxl_t3d_volatile_lsa);
> +        qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
> +        qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4",
> +                       cxl_2pxb_4rp_4t3d);
>  #endif
> +    } else if (strcmp(arch, "aarch64") == 0) {
> +#ifdef CONFIG_POSIX
> +        qtest_add_func("/pci/cxl/virt/pxb_x2_root_port_x4_type3_x4",
> +                       cxl_virt_2pxb_4rp_4t3d);
> +#endif
> +    }
> +
>      return g_test_run();
>  }
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 8ad849054f..42e927b32a 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -261,6 +261,7 @@ qtests_aarch64 = \
>     config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
>    (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed64 : []) + \
>    (config_all_devices.has_key('CONFIG_NPCM8XX') ? qtests_npcm8xx : []) + \
> +  qtests_cxl +                                                                                  \
>    ['arm-cpu-features',
>     'numa-test',
>     'boot-serial-test',

