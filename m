Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528199;
	b=VMQGJOagl+UV1OFIK79Id0GuUAmDAiLpKSvqady4WuaGZT8lWzohaCjgdFO76r6n5v5e
	 Z/7gepGTqtJuE433HOyBVUK3X4uP40dmzY2DAraEh8+2y4hYktRlpaY2XBO3KzX694l3r
	 8Z2BzNXcGoBbuc4KKEWcoazBCkqXuNBf8C2abdpsQbnWV102JxORPYy2yTZv76r5kwwbJ
	 u4S4ivZJ02IyBBVGFWW7GWOQ9hXrVMPbwt6OUiZt53EcKSeJUaAyxriVdQMZT93eUMdO/
	 7IOhDB2pW18o4k9e5MvJPuMR+5OSwaH3neA+qqg46r4OfVprR7OSZWJOfL7rNEnbAbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528199;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:Reply-To:
	 To:Cc:Date:In-Reply-To:References:Organization:Content-Type:X-Mailer:
	 Mime-Version:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Pbg2OFXa34DEIIHpJyaCulmgUfbxOrfxEkZAKRhMex4=;
	b=t/v714i1CzHCkxhtYgEHW9Jn1AqghxlkGhOriQWFiGNK32VnpbFQTRP8a3IJsQMk/p5U
	 0SlibgWzoF8vGBM4Sh1W09y2U+aBoG+zwCacvoOWwFghiv1zLLirbeyRJzus76dSMCuvi
	 Wy+9g4NiPaH3j1s464Mz3hy6UKitidteb+qsuMLgI5tqO70VWmDFeUd864GopFdwpSOzO
	 X8otEkfxrDhCkxCGe/KFGalAQxenS9divSAIMFs5P6sCL8N3yH4XNbG25o/ijM5CpswmK
	 4K2AU/oSFIdi3V8YfrxD/F8KKuTiObr4rBm8CmuD4oehmtwXQxUFvaMf8vM42QWYgSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gryBQiZp;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C3E606A319;
	Tue, 20 Oct 2026 20:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23C3E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gryBQiZp
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KHEaMW3065410;
	Tue, 20 Oct 2026 20:28:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=Pbg2OFXa34DEIIHpJyaCulmgUfbxOrfxEkZAKRhMex4=; b=gryBQiZpYaYe
	+rscbtJOMUMGzJILaO9bxcqwAzLIOX+j60zcXWH7tKvp08o40WoTpUGVyLoqWjGF
	ZkUPXLwP8RwgFXaLLDWNzTKj3ap3mJdD1BO/1HXfs1dYuHwb9rWeRqt8GowmS644
	50UL+brNoroymAw4we0HPjTOmE1wcH9sGecmJN6hvUF49OvQ80slVcDAhqxSmPlQ
	hSAB89mjuxAM4Xy/czGuXpXvp+9ip0/G8lAJ8i3S+uKSjmnkBnAPhxEv9O4Zujz+
	n5IQ9SrRLVR2AI3cmiOziLyzdt3R0G+SY7SZNguBEHE3h6jlPLu0ojoSEWc6Cwsc
	weZZ1xQpeA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5a58tk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 20:28:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69KKOc4J1753723;
	Tue, 20 Oct 2026 20:28:57 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4he7bs2390-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 20:28:57 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69KKSu7F26542802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Oct 2026 20:28:56 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AF0B58059;
	Tue, 20 Oct 2026 20:28:56 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39C1758053;
	Tue, 20 Oct 2026 20:28:49 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Oct 2026 20:28:49 +0000 (GMT)
Message-ID: <9623e038a99fbaa32f3b674335b717aaac28a9b7.camel@linux.ibm.com>
Subject: Re: [PATCH v7 48/65] hw/gpio/pca955x: use QAPI enums for led and
 pin properties
From: Miles Glenn <milesg@linux.ibm.com>
Reply-To: milesg@linux.ibm.com
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
        qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
        Michael Roth
 <michael.roth@amd.com>, John Snow <jsnow@redhat.com>,
        Peter Maydell
 <peter.maydell@linaro.org>,
        Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,
        Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>,
        Kostiantyn
 Kostiuk <kkostiuk@redhat.com>,
        Eric Blake <eblake@redhat.com>, David
 Hildenbrand <david@kernel.org>,
        Igor Mammedov <imammedo@redhat.com>,
        "Edgar
 E. Iglesias" <edgar.iglesias@gmail.com>,
        Jason Wang <jasowangio@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
        Alberto Garcia
 <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
        Hanna Reitz
 <hreitz@redhat.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@oss.qualcomm.com>,
        Zhao Liu <zhao1.liu@intel.com>, Jonathan Cameron
 <jic23@kernel.org>,
        Junjie Cao <junjie.cao@intel.com>, Anisa Su
 <anisa.su@samsung.com>,
        Elena Ufimtseva <elena.ufimtseva@oracle.com>,
        Jagannathan Raman <jag.raman@oracle.com>,
        John Levon
 <john.levon@nutanix.com>,
        Thanos Makatos <thanos.makatos@nutanix.com>,
        =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
        Cornelia Huck
 <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato
 <mjrosato@linux.ibm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>, qemu-block@nongnu.org,
        linux-cxl@vger.kernel.org, qemu-s390x@nongnu.org,
        "Michael S. Tsirkin"
 <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
        qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Alistair Francis
 <alistair.francis@wdc.com>,
        Weiwei Li <liwei1518@gmail.com>,
        Daniel
 Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,
        Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
        Song Gao <17746591750@163.com>, Bibo Mao
 <maobibo@loongson.cn>,
        Xianglai Li <lixianglai@loongson.cn>,
        Jiaxun Yang
 <jiaxun.yang@flygoat.com>,
        Pedro Barbuda <pbarbuda@microsoft.com>,
        Mohamed
 Mediouni <mohamed@unpredictable.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Amit Machhiwal
 <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org,
        Zhang Chen
 <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>,
        Alistair Francis
 <alistair@alistair23.me>,
        Alexander Graf <graf@amazon.com>,
        "Gonglei
 (Arei)" <arei.gonglei@huawei.com>,
        zhenwei pi <zhenwei.pi@linux.dev>, Ani
 Sinha <anisinha@redhat.com>,
        Luc Michel <luc@lmichel.fr>,
        =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        Jamin Lin
 <jamin_lin@aspeedtech.com>,
        Kane Chen <kane_chen@aspeedtech.com>,
        Samuel
 Tardieu <sam@rfc1149.net>, "Denis V. Lunev" <den@openvz.org>,
        FangSheng
 Huang <FangSheng.Huang@amd.com>,
        Tyrone Ting <kfting@nuvoton.com>, Hao Wu
 <wuhaotsh@google.com>,
        Keith Busch <kbusch@kernel.org>, Klaus Jensen
 <its@irrelevant.dk>,
        Jesper Devantier <foss@defmacro.it>,
        Aditya Gupta
 <adityag@linux.ibm.com>, Conor Dooley <conor@kernel.org>,
        Sebastian Huber
 <sebastian.huber@embedded-brains.de>,
        Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jason Herne
 <jjherne@linux.ibm.com>,
        Titus Rwantare <titusr@google.com>,
        Stefano
 Stabellini <sstabellini@kernel.org>,
        Anthony PERARD
 <anthony@xenproject.org>, Peter Xu <peterx@redhat.com>,
        Chinmay Rath
 <rathc@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        xen-devel@lists.xenproject.org, Roman Bolshakov <rbolshakov@ddn.com>,
        Phil
 Dennis-Jordan <phil@philjordan.eu>, Fam Zheng <fam@euphon.net>,
        Farhan Ali
 <alifm@linux.ibm.com>, Alex Williamson <alex@shazbot.org>,
        Tao Tang
 <tangtao1634@phytium.com.cn>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Fabiano Rosas <farosas@suse.de>,
        Mark Cave-Ayland
 <mark.cave-ayland@ilande.co.uk>,
        Artyom Tarasenko <atar4qemu@gmail.com>,
        Yoshinori Sato <yoshinori.sato@nifty.com>,
        Jiri Pirko <jiri@resnulli.us>, Eric Auger <eric.auger@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>
Date: Tue, 20 Oct 2026 15:28:48 -0500
In-Reply-To: <20261020-qom-qapi-v7-48-431a86b02b58@redhat.com>
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
	 <20261020-qom-qapi-v7-48-431a86b02b58@redhat.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA4MCBTYWx0ZWRfX+9t/y7lhb2NG
 WRjTvBs8OQevzx4sdzmL6Tx48u4P32LMaUsHknmvsUzsQaucLioBR2sjCY6GT3OJ4yssLuDC0EO
 xJOE2Sdth5z5s9nQwh6PUys3fZGefWM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA4MCBTYWx0ZWRfX3Qu0Fruw9FfE
 Ym4jZr96pufaiiUd4/rQ1VRiwxdBVMEJLalf3ME9JEtAQaN6Yhv0QwgryMUZTbXSXwg/DfZZCl7
 /xP3aEF4DBW1yJT16UvGIlCC8savRUWw67ZIp3OUezPcqsRlbBNFuScIw7bh74KPfDDfp3UWH0H
 tkc7dPCd5QXXhKqVxbaO61OTVKvMRVzCRXgvlL5Qw6pAHPkVV4ALHoA7o+NX+SE29WGhwk1ozVa
 hTadZPgXjdOlRadT+Pzkf9PEbGlkJf2S995AwjStoV4mJwbnBdy1JmwZiXYnkVD6m8dGRXVBSUJ
 hTMlIbAgYthVor/1Dab5nXl+SPjghbjOfG1OzOZ1req4HJPion9UERcDGtLjrnNyDZ3j0kysEDi
 cUR7EwYhI81VbRMm2Ocx47cZ1J++/t1P8i3Q1GulTumaAI6YDA09Bd7ZCbpejcrAF8paLII0Pm6
 KD8z5UTW5GBvooZYOJw==
X-Proofpoint-GUID: B9E0T9KfFgRckvDuzc9Ax4ROrE9sxB9M
X-Authority-Analysis: v=2.4 cv=JIKuIMKb c=1 sm=1 tr=0 ts=6ad7cf0b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=HV9-su-gHPMe9Pw3G_AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: B9E0T9KfFgRckvDuzc9Ax4ROrE9sxB9M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1011
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200080

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Tue, 2026-10-20 at 14:46 +0400, Marc-André Lureau wrote:
> Replace hand-rolled string lookup tables with QAPI enums
> Pca9552LedState and Pca955{2,4}PinState for the led%d and pin%d QOM
> properties. This fixes the incorrect property type ("bool" for LEDs,
> "str" for pins) and lets QAPI handle string-to-enum conversion in the
> visitor, removing the manual string matching in the setters.
> 
> Add QEMU_BUILD_BUG_ON guards to ensure the QAPI-generated enum values
> stay in sync with the hardware register encoding.
> 
> I kept Pca9552PinState & @Pca9554PinState separate types, because I
> don't know if they could diverge. We could eventually merge those.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/gpio/pca9552.c | 82 +++++++++++++++++++++----------------------------------
>  hw/gpio/pca9554.c | 39 ++++++++++----------------
>  qapi/machine.json | 46 +++++++++++++++++++++++++++++++
>  3 files changed, 92 insertions(+), 75 deletions(-)
> 
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index 719149b7174b..16741c22dea3 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -23,7 +23,8 @@
>  #include "hw/core/irq.h"
>  #include "migration/vmstate.h"
>  #include "qapi/error.h"
> -#include "qapi/visitor.h"
> +#include "qapi/qapi-types-machine.h"
> +#include "qapi/qapi-visit-machine.h"
>  #include "trace.h"
>  #include "qom/object.h"
>  
> @@ -59,16 +60,15 @@ struct PCA955xClass {
>  /*
>   * Note:  The LED_ON and LED_OFF configuration values for the PCA955X
>   *        chips are the reverse of the PCA953X family of chips.
> + *
> + * The QAPI enums must match the hardware register values.
>   */
> -#define PCA9552_LED_ON   0x0
> -#define PCA9552_LED_OFF  0x1
> -#define PCA9552_LED_PWM0 0x2
> -#define PCA9552_LED_PWM1 0x3
> -#define PCA9552_PIN_LOW  0x0
> -#define PCA9552_PIN_HIZ  0x1
> -
> -static const char *led_state[] = {"on", "off", "pwm0", "pwm1"};
> -static const char *pin_state[] = {"low", "high"};
> +QEMU_BUILD_BUG_ON(PCA9552_LED_STATE_ON != 0x0);
> +QEMU_BUILD_BUG_ON(PCA9552_LED_STATE_OFF != 0x1);
> +QEMU_BUILD_BUG_ON(PCA9552_LED_STATE_PWM0 != 0x2);
> +QEMU_BUILD_BUG_ON(PCA9552_LED_STATE_PWM1 != 0x3);
> +QEMU_BUILD_BUG_ON(PCA9552_PIN_STATE_LOW != 0x0);
> +QEMU_BUILD_BUG_ON(PCA9552_PIN_STATE_HIGH != 0x1);
>  
>  static uint8_t pca955x_pin_get_config(PCA955xState *s, int pin)
>  {
> @@ -142,24 +142,24 @@ static void pca955x_update_pin_input(PCA955xState *s)
>              uint8_t config = pca955x_pin_get_config(s, i);
>  
>              switch (config) {
> -            case PCA9552_LED_ON:
> +            case PCA9552_LED_STATE_ON:
>                  /* Pin is set to 0V to turn on LED */
>                  s->regs[input_reg] &= ~bit_mask;
>                  break;
> -            case PCA9552_LED_OFF:
> +            case PCA9552_LED_STATE_OFF:
>                  /*
>                   * Pin is set to Hi-Z to turn off LED and
>                   * pullup sets it to a logical 1 unless
>                   * external device drives it low.
>                   */
> -                if (s->ext_state[i] == PCA9552_PIN_LOW) {
> +                if (s->ext_state[i] == PCA9552_PIN_STATE_LOW) {
>                      s->regs[input_reg] &= ~bit_mask;
>                  } else {
>                      s->regs[input_reg] |=  bit_mask;
>                  }
>                  break;
> -            case PCA9552_LED_PWM0:
> -            case PCA9552_LED_PWM1:
> +            case PCA9552_LED_STATE_PWM0:
> +            case PCA9552_LED_STATE_PWM1:
>                  /* TODO */
>              default:
>                  break;
> @@ -176,7 +176,7 @@ static void pca955x_update_pin_input(PCA955xState *s)
>               */
>              if (s->regs[config_reg] & bit_mask) {
>                  /* Input mode - reflect external state */
> -                if (s->ext_state[i] == PCA9552_PIN_LOW) {
> +                if (s->ext_state[i] == PCA9552_PIN_STATE_LOW) {
>                      s->regs[input_reg] &= ~bit_mask;
>                  } else {
>                      s->regs[input_reg] |= bit_mask;
> @@ -360,7 +360,7 @@ static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
>      PCA955xClass *k = PCA955X_GET_CLASS(obj);
>      PCA955xState *s = PCA955X(obj);
>      int led, rc, reg;
> -    uint8_t state;
> +    Pca9552LedState state;
>  
>      rc = sscanf(name, "led%2d", &led);
>      if (rc != 1) {
> @@ -378,7 +378,7 @@ static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
>       */
>      reg = PCA9552_LS0 + led / 4;
>      state = (pca955x_read(s, reg) >> ((led % 4) * 2)) & 0x3;
> -    visit_type_str(v, name, (char **)&led_state[state], errp);
> +    visit_type_Pca9552LedState(v, name, &state, errp);
>  }
>  
>  /*
> @@ -397,10 +397,9 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
>      PCA955xClass *k = PCA955X_GET_CLASS(obj);
>      PCA955xState *s = PCA955X(obj);
>      int led, rc, reg, val;
> -    uint8_t state;
> -    g_autofree char *state_str = NULL;
> +    Pca9552LedState state;
>  
> -    if (!visit_type_str(v, name, &state_str, errp)) {
> +    if (!visit_type_Pca9552LedState(v, name, &state, errp)) {
>          return;
>      }
>      rc = sscanf(name, "led%2d", &led);
> @@ -413,16 +412,6 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
>          return;
>      }
>  
> -    for (state = 0; state < ARRAY_SIZE(led_state); state++) {
> -        if (!strcmp(state_str, led_state[state])) {
> -            break;
> -        }
> -    }
> -    if (state >= ARRAY_SIZE(led_state)) {
> -        error_setg(errp, "%s invalid led state %s", __func__, state_str);
> -        return;
> -    }
> -
>      reg = PCA9552_LS0 + led / 4;
>      val = pca955x_read(s, reg);
>      val = pca955x_ledsel(val, led % 4, state);
> @@ -437,7 +426,8 @@ static void pca955x_get_pin(Object *obj, Visitor *v, const char *name,
>      PCA955xClass *k = PCA955X_GET_CLASS(obj);
>      PCA955xState *s = PCA955X(obj);
>      int pin, rc;
> -    uint8_t input_reg, state;
> +    uint8_t input_reg;
> +    Pca9552PinState state;
>  
>      rc = sscanf(name, "pin%2d", &pin);
>      if (rc != 1) {
> @@ -455,7 +445,7 @@ static void pca955x_get_pin(Object *obj, Visitor *v, const char *name,
>       */
>      input_reg = PCA9535_INPUT0 + (pin / 8);
>      state = (s->regs[input_reg] >> (pin % 8)) & 0x1;
> -    visit_type_str(v, name, (char **)&pin_state[state], errp);
> +    visit_type_Pca9552PinState(v, name, &state, errp);
>  }
>  
>  static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
> @@ -464,10 +454,10 @@ static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
>      PCA955xClass *k = PCA955X_GET_CLASS(obj);
>      PCA955xState *s = PCA955X(obj);
>      int pin, rc;
> -    uint8_t state, config_reg;
> -    g_autofree char *state_str = NULL;
> +    Pca9552PinState state;
> +    uint8_t config_reg;
>  
> -    if (!visit_type_str(v, name, &state_str, errp)) {
> +    if (!visit_type_Pca9552PinState(v, name, &state, errp)) {
>          return;
>      }
>      rc = sscanf(name, "pin%2d", &pin);
> @@ -480,16 +470,6 @@ static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
>          return;
>      }
>  
> -    for (state = 0; state < ARRAY_SIZE(pin_state); state++) {
> -        if (!strcmp(state_str, pin_state[state])) {
> -            break;
> -        }
> -    }
> -    if (state >= ARRAY_SIZE(pin_state)) {
> -        error_setg(errp, "%s invalid pin state %s", __func__, state_str);
> -        return;
> -    }
> -
>      /* Only input-configured pins can be driven by an external device. */
>      config_reg = PCA9535_CONFIG0 + (pin / 8);
>      if (!((s->regs[config_reg] >> (pin % 8)) & 0x1)) {
> @@ -499,7 +479,7 @@ static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
>          return;
>      }
>  
> -    pca955x_set_ext_state(s, pin, state != PCA9552_PIN_LOW);
> +    pca955x_set_ext_state(s, pin, state != PCA9552_PIN_STATE_LOW);
>  }
>  
>  static const VMStateDescription pca9552_vmstate = {
> @@ -529,7 +509,7 @@ static void pca9552_reset_hold(Object *obj, ResetType type)
>      s->regs[PCA9552_LS2] = 0x55;
>      s->regs[PCA9552_LS3] = 0x55;
>  
> -    memset(s->ext_state, PCA9552_PIN_HIZ, PCA955X_PIN_COUNT_MAX);
> +    memset(s->ext_state, PCA9552_PIN_STATE_HIGH, PCA955X_PIN_COUNT_MAX);
>      pca955x_update_pin_input(s);
>  
>      s->pointer = 0xFF;
> @@ -549,7 +529,7 @@ static void pca9535_reset_hold(Object *obj, ResetType type)
>      s->regs[PCA9535_CONFIG0] = 0xFF;  /* All pins as inputs */
>      s->regs[PCA9535_CONFIG1] = 0xFF;  /* All pins as inputs */
>  
> -    memset(s->ext_state, PCA9552_PIN_HIZ, PCA955X_PIN_COUNT_MAX);
> +    memset(s->ext_state, PCA9552_PIN_STATE_HIGH, PCA955X_PIN_COUNT_MAX);
>      pca955x_update_pin_input(s);
>  
>      s->pointer = 0xFF;
> @@ -567,12 +547,12 @@ static void pca955x_initfn(Object *obj)
>          if (k->has_led_support) {
>              /* LED variant: expose the LED selector state as led%d. */
>              name = g_strdup_printf("led%d", ix);
> -            object_property_add(obj, name, "bool",
> +            object_property_add(obj, name, "Pca9552LedState",
>                                  pca955x_get_led, pca955x_set_led, NULL, NULL);
>          } else {
>              /* GPIO variant: expose the pin logic level as pin%d. */
>              name = g_strdup_printf("pin%d", ix);
> -            object_property_add(obj, name, "str",
> +            object_property_add(obj, name, "Pca9552PinState",
>                                  pca955x_get_pin, pca955x_set_pin, NULL, NULL);
>          }
>          g_free(name);
> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
> index 904698cdce85..e4eddc829ef7 100644
> --- a/hw/gpio/pca9554.c
> +++ b/hw/gpio/pca9554.c
> @@ -16,6 +16,8 @@
>  #include "hw/core/irq.h"
>  #include "migration/vmstate.h"
>  #include "qapi/error.h"
> +#include "qapi/qapi-types-machine.h"
> +#include "qapi/qapi-visit-machine.h"
>  #include "qapi/visitor.h"
>  #include "trace.h"
>  #include "qom/object.h"
> @@ -32,10 +34,8 @@ typedef struct PCA9554Class PCA9554Class;
>  DECLARE_CLASS_CHECKERS(PCA9554Class, PCA9554,
>                         TYPE_PCA9554)
>  
> -#define PCA9554_PIN_LOW  0x0
> -#define PCA9554_PIN_HIZ  0x1
> -
> -static const char *pin_state[] = {"low", "high"};
> +QEMU_BUILD_BUG_ON(PCA9554_PIN_STATE_LOW != 0x0);
> +QEMU_BUILD_BUG_ON(PCA9554_PIN_STATE_HIGH != 0x1);
>  
>  static void pca9554_update_pin_input(PCA9554State *s)
>  {
> @@ -54,7 +54,7 @@ static void pca9554_update_pin_input(PCA9554State *s)
>               * Input: the pin is Hi-Z with a pull-up, so it reads high
>               * unless an external device drives it low.
>               */
> -            if (s->ext_state[i] == PCA9554_PIN_LOW) {
> +            if (s->ext_state[i] == PCA9554_PIN_STATE_LOW) {
>                  s->regs[PCA9554_INPUT] &= ~bit_mask;
>              } else {
>                  s->regs[PCA9554_INPUT] |= bit_mask;
> @@ -156,7 +156,7 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
>  {
>      PCA9554State *s = PCA9554(obj);
>      int pin, rc;
> -    uint8_t state;
> +    Pca9554PinState state;
>  
>      rc = sscanf(name, "pin%2d", &pin);
>      if (rc != 1) {
> @@ -175,7 +175,7 @@ static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
>       * holds the wire level regardless of the configured direction.
>       */
>      state = (s->regs[PCA9554_INPUT] >> pin) & 0x1;
> -    visit_type_str(v, name, (char **)&pin_state[state], errp);
> +    visit_type_Pca9554PinState(v, name, &state, errp);
>  }
>  
>  static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
> @@ -183,10 +183,10 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
>  {
>      PCA9554State *s = PCA9554(obj);
>      int pin, rc, val;
> -    uint8_t state, mask;
> -    g_autofree char *state_str = NULL;
> +    uint8_t mask;
> +    Pca9554PinState state;
>  
> -    if (!visit_type_str(v, name, &state_str, errp)) {
> +    if (!visit_type_Pca9554PinState(v, name, &state, errp)) {
>          return;
>      }
>      rc = sscanf(name, "pin%2d", &pin);
> @@ -199,16 +199,6 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
>          return;
>      }
>  
> -    for (state = 0; state < ARRAY_SIZE(pin_state); state++) {
> -        if (!strcmp(state_str, pin_state[state])) {
> -            break;
> -        }
> -    }
> -    if (state >= ARRAY_SIZE(pin_state)) {
> -        error_setg(errp, "%s invalid pin state %s", __func__, state_str);
> -        return;
> -    }
> -
>      if (s->hw_dir) {
>          /* Warn and ignore if the guest has configured this pin as output */
>          if (!((s->regs[PCA9554_CONFIG] >> pin) & 0x1)) {
> @@ -219,13 +209,13 @@ static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
>              return;
>          }
>          /* Drive the external input level */
> -        pca9554_set_ext_state(s, pin, state != PCA9554_PIN_LOW);
> +        pca9554_set_ext_state(s, pin, state != PCA9554_PIN_STATE_LOW);
>      } else {
>          /* Legacy behavior: force output mode and drive */
>          /* First, modify the output register bit */
>          val = pca9554_read(s, PCA9554_OUTPUT);
>          mask = 0x1 << pin;
> -        if (state == PCA9554_PIN_LOW) {
> +        if (state == PCA9554_PIN_STATE_LOW) {
>              val &= ~(mask);
>          } else {
>              val |= mask;
> @@ -264,7 +254,7 @@ static void pca9554_reset(DeviceState *dev)
>      s->regs[PCA9554_POLARITY] = 0x0; /* No pins are inverted */
>      s->regs[PCA9554_CONFIG] = pin_mask; /* All pins are inputs */
>  
> -    memset(s->ext_state, PCA9554_PIN_HIZ, pc->pin_count);
> +    memset(s->ext_state, PCA9554_PIN_STATE_HIGH, pc->pin_count);
>      pca9554_update_pin_input(s);
>  
>      s->pointer = 0x0;
> @@ -280,7 +270,8 @@ static void pca9554_initfn(Object *obj)
>          char *name;
>  
>          name = g_strdup_printf("pin%d", pin);
> -        object_property_add(obj, name, "str", pca9554_get_pin, pca9554_set_pin,
> +        object_property_add(obj, name, "Pca9554PinState",
> +                            pca9554_get_pin, pca9554_set_pin,
>                              NULL, NULL);
>          g_free(name);
>      }
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 34be3156270c..46b6935ab0b8 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -416,6 +416,52 @@
>  { 'enum': 'LostTickPolicy',
>    'data': ['discard', 'delay', 'slew' ] }
>  
> +##
> +# @Pca9552LedState:
> +#
> +# LED state for PCA9552.
> +#
> +# @on: LED on
> +#
> +# @off: LED off
> +#
> +# @pwm0: LED controlled by PWM0
> +#
> +# @pwm1: LED controlled by PWM1
> +#
> +# Since: 11.2
> +##
> +{ 'enum': 'Pca9552LedState',
> +  'data': ['on', 'off', 'pwm0', 'pwm1'] }
> +
> +##
> +# @Pca9552PinState:
> +#
> +# Pin state for PCA9552.
> +#
> +# @low: Pin low
> +#
> +# @high: Pin high
> +#
> +# Since: 11.2
> +##
> +{ 'enum': 'Pca9552PinState',
> +  'data': ['low', 'high'] }
> +
> +##
> +# @Pca9554PinState:
> +#
> +# Pin state for PCA9554.
> +#
> +# @low: Pin low
> +#
> +# @high: Pin high
> +#
> +# Since: 11.2
> +##
> +{ 'enum': 'Pca9554PinState',
> +  'data': ['low', 'high'] }
> +
>  ##
>  # @inject-nmi:
>  #     Injects a Non-Maskable Interrupt (machine specific: for example
> 

