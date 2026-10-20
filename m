Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792528949;
	b=XetNBbYFdeLpF2hCKbljI2AltD3qpWthmIevdJUmZNvoasTfyeGZMg4/XUMEJMfacalm
	 g1iVkvch/zP7srtYq0UcRkcDXu0kqPjg2bRfA8r9KRAraEHtbHu6wyYcZ8wKmfe44Zvlz
	 44rSHIncGKMe5HCtI84NApKG7QeWLkVURPziEIWgbXUHuEShpWKAQ2heBCmxR+W4Rm5cd
	 7YSd/q29/Zwv80rx47mj29KVX7+4UGw8eSNjpYU0CF7vz9PcTGQMOOolvjOeHFGGRkKHR
	 CG7UtH1C7LY9ejZ0kc/74TrdiVmcWThglqmwEFsN9ImkYYkRVsMBENaGa48Ia2h68jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792528949;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Subject:From:Reply-To:
	 To:Cc:Date:In-Reply-To:References:Organization:Content-Type:X-Mailer:
	 Mime-Version:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ZUXi7wiEMe2tdgO/StfvU9pGNatYDPEYkYpr3SsxzLE=;
	b=Ov+lDn36LVL/NpfocZifQv6VOUJh2W+ZkdKZoiA9wxEHMR1v+Dz9MIdC2cfid2S4qOIC
	 3K55uh+23HaJhGeowF2bglxKUupErQV+u1vMebyiSRPxW5RBy0Q6clV+za/xusKjVbFkV
	 b/IbvwrvyVEP70FwdqsuvBUxx3U7xw8oguMrxUCwJk5HceTmnaT4ZIEz4mfwBLUjtGE2G
	 Kj46OrOtI97n7gdPWWG9NzzqFc0gvtZ5JRadxjze3uLPHmOdDaGmpNHtrGoeAWECH4B4i
	 FVEwX6fJ6kSSlkDbspzOZc4sDoRuLTaChepc1SlLaO8oXjeLcqWsdxiPRWZLpVUJsqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RlDigF9l;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBDE606A319;
	Tue, 20 Oct 2026 20:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EBDE606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RlDigF9l
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KHEB393063241;
	Tue, 20 Oct 2026 20:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=ZUXi7wiEMe2tdgO/StfvU9pGNatYDPEYkYpr3SsxzLE=; b=RlDigF9lsTqM
	tTcz67lqRcQIIyKRfsH2omumJlO9v1oYu2keY01iqqNQY/OXRuHPKVgo+dusPdJ7
	TGMAmQzdHEtoUzqBRRB+p2jRhm6uspUWal7wI9ETaxB7v4JQ8JU5l6ekl6yl63h0
	I5F4rs0YN/foiumMEHVENZdyuVKFpnRoCVJlw8ZkHcMXj4EXARAPQW9qDiGT/1W1
	7JY5cppKkFFpP3zE73cbYFUhDIa9gIU/EWG1a0lLAkWMg7J+Tay56rcVl0KlsR7s
	ep0odC2xwDk5qAi4L9bWaylnuZpgl4gDIDJAdCxdP4u5plML+T+q41SD70UW1Go0
	J7KgO4BwPQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5a5aad-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 20:41:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69KKL8rN1753729;
	Tue, 20 Oct 2026 20:41:36 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4he7bs24g1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 20:41:36 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69KKfZRk12517922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Oct 2026 20:41:35 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F0905805E;
	Tue, 20 Oct 2026 20:41:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD8ED58058;
	Tue, 20 Oct 2026 20:41:27 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Oct 2026 20:41:27 +0000 (GMT)
Message-ID: <b71f57e2e611b24bed7c0db597cfa8acd4336460.camel@linux.ibm.com>
Subject: Re: [PATCH v7 50/65] hw/gpio/pca955x: convert pin/led property to
 QAPI-aware enum
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
Date: Tue, 20 Oct 2026 15:41:27 -0500
In-Reply-To: <20261020-qom-qapi-v7-50-431a86b02b58@redhat.com>
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
	 <20261020-qom-qapi-v7-50-431a86b02b58@redhat.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA4MCBTYWx0ZWRfXx3qS+ltKGMOc
 yqT6/U/zlRDRtOXgjweUHTO6kjnMlIEfBwnAfjKqdmEiH/7hpTWB4HtjOmJys44IP6/IXR1xcCB
 ELxHYSnNsgHIFFodK6L8eeKv/ngFzsk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA4MCBTYWx0ZWRfX7l3aUJraVDdJ
 4pIK/7AUMSedHh/0Jmqhh9VdRxIGAtEkvguIjSId7usIs3qNz+l2SdKzkGG0EtgJox8ZyBtZ/8+
 BebxfgggLrI1hF2U9WbPrlRHAve6E0TSVsvoh0s2RGgCYJ6uItsvxCIUO5px4lDNY4F8ubXVdnb
 d1N3xW5+ER6/6VbetgQybwqJuQUZis2yRJW5occ+IXZwuNsNVczrTnlgzZM+Evf8UAnOlJHxP3O
 QjH/mvIgh1dInuxwKFwvpXRTR3XWMlupiLdRAb759Jbm3RXJNz3gA4Q+KhTmlCUAsjwkpEBpWo4
 Atl7TdFp4QZlqDnDhq9+Im8szKRCQXOreHMQUF7XjaRmgpYKdxUT1DT++1HmclZ44lOCBymbE+6
 covS3ph1ZUHLGRF0xSgQJlvHb4IIGvOhe6fhGxmusGXPqBLizxkw95IZtZahur0+xqKkhdoYD6O
 ZfseyJsocAfbPz1vxfg==
X-Proofpoint-GUID: KJk0L_-fIGnyWPXZNbrP_za0LNmVv4BO
X-Authority-Analysis: v=2.4 cv=JIKuIMKb c=1 sm=1 tr=0 ts=6ad7d201 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8
 a=zBbYNmvnHTV63AnQkW4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: KJk0L_-fIGnyWPXZNbrP_za0LNmVv4BO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200080

On Tue, 2026-10-20 at 14:46 +0400, Marc-André Lureau wrote:
> Replaces the runtime-parsed visitor-based QOM property accessors with
> compile-time per-pin/per-LED accessor functions using QEMU_REPEAT.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/gpio/pca9552.c | 205 +++++++++++++++++++++---------------------------------
>  hw/gpio/pca9554.c | 136 ++++++++++++++----------------------
>  2 files changed, 131 insertions(+), 210 deletions(-)
> 
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index 16741c22dea3..0a007bbbe4ac 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -25,6 +25,7 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-types-machine.h"
>  #include "qapi/qapi-visit-machine.h"

Do you still need to include qapi/qapi-visit-machine.h?

> +#include "qapi/qapi-type-infos-machine.h"
>  #include "trace.h"
>  #include "qom/object.h"
>  
> @@ -354,33 +355,6 @@ static int pca955x_event(I2CSlave *i2c, enum i2c_event event)
>      return 0;
>  }
>  
> -static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
> -                            void *opaque, Error **errp)
> -{
> -    PCA955xClass *k = PCA955X_GET_CLASS(obj);
> -    PCA955xState *s = PCA955X(obj);
> -    int led, rc, reg;
> -    Pca9552LedState state;
> -
> -    rc = sscanf(name, "led%2d", &led);
> -    if (rc != 1) {
> -        error_setg(errp, "%s: error reading %s", __func__, name);
> -        return;
> -    }
> -    if (led < 0 || led >= k->pin_count) {
> -        error_setg(errp, "%s: invalid led %s", __func__, name);
> -        return;
> -    }
> -    /*
> -     * Get the LSx register as the qom interface should expose the device
> -     * state, not the modeled 'input line' behaviour which would come from
> -     * reading the INPUTx reg
> -     */
> -    reg = PCA9552_LS0 + led / 4;
> -    state = (pca955x_read(s, reg) >> ((led % 4) * 2)) & 0x3;
> -    visit_type_Pca9552LedState(v, name, &state, errp);
> -}
> -
>  /*
>   * Return an LED selector register value based on an existing one, with
>   * the appropriate 2-bit state value set for the given LED number (0-3).
> @@ -391,97 +365,8 @@ static inline uint8_t pca955x_ledsel(uint8_t oldval, int led_num, int state)
>                  ((state & 0x3) << (led_num << 1));
>  }
>  
> -static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
> -                            void *opaque, Error **errp)
> -{
> -    PCA955xClass *k = PCA955X_GET_CLASS(obj);
> -    PCA955xState *s = PCA955X(obj);
> -    int led, rc, reg, val;
> -    Pca9552LedState state;
> -
> -    if (!visit_type_Pca9552LedState(v, name, &state, errp)) {
> -        return;
> -    }
> -    rc = sscanf(name, "led%2d", &led);
> -    if (rc != 1) {
> -        error_setg(errp, "%s: error reading %s", __func__, name);
> -        return;
> -    }
> -    if (led < 0 || led >= k->pin_count) {
> -        error_setg(errp, "%s: invalid led %s", __func__, name);
> -        return;
> -    }
> -
> -    reg = PCA9552_LS0 + led / 4;
> -    val = pca955x_read(s, reg);
> -    val = pca955x_ledsel(val, led % 4, state);
> -    pca955x_write(s, reg, val);
> -}
> -
>  static void pca955x_set_ext_state(PCA955xState *s, int pin, int level);
>  
> -static void pca955x_get_pin(Object *obj, Visitor *v, const char *name,
> -                            void *opaque, Error **errp)
> -{
> -    PCA955xClass *k = PCA955X_GET_CLASS(obj);
> -    PCA955xState *s = PCA955X(obj);
> -    int pin, rc;
> -    uint8_t input_reg;
> -    Pca9552PinState state;
> -
> -    rc = sscanf(name, "pin%2d", &pin);
> -    if (rc != 1) {
> -        error_setg(errp, "%s: error reading %s", __func__, name);
> -        return;
> -    }
> -    if (pin < 0 || pin >= k->pin_count) {
> -        error_setg(errp, "%s invalid pin %s", __func__, name);
> -        return;
> -    }
> -
> -    /*
> -     * Report the raw pin logic level; polarity inversion is a read-time
> -     * transform applied to the INPUT register, not to the pin state itself.
> -     */
> -    input_reg = PCA9535_INPUT0 + (pin / 8);
> -    state = (s->regs[input_reg] >> (pin % 8)) & 0x1;
> -    visit_type_Pca9552PinState(v, name, &state, errp);
> -}
> -
> -static void pca955x_set_pin(Object *obj, Visitor *v, const char *name,
> -                            void *opaque, Error **errp)
> -{
> -    PCA955xClass *k = PCA955X_GET_CLASS(obj);
> -    PCA955xState *s = PCA955X(obj);
> -    int pin, rc;
> -    Pca9552PinState state;
> -    uint8_t config_reg;
> -
> -    if (!visit_type_Pca9552PinState(v, name, &state, errp)) {
> -        return;
> -    }
> -    rc = sscanf(name, "pin%2d", &pin);
> -    if (rc != 1) {
> -        error_setg(errp, "%s: error reading %s", __func__, name);
> -        return;
> -    }
> -    if (pin < 0 || pin >= k->pin_count) {
> -        error_setg(errp, "%s invalid pin %s", __func__, name);
> -        return;
> -    }
> -
> -    /* Only input-configured pins can be driven by an external device. */
> -    config_reg = PCA9535_CONFIG0 + (pin / 8);
> -    if (!((s->regs[config_reg] >> (pin % 8)) & 0x1)) {
> -        qemu_log_mask(LOG_UNIMP,
> -                      "%s: pin %d is configured as output, ignoring set\n",
> -                      s->description, pin);
> -        return;
> -    }
> -
> -    pca955x_set_ext_state(s, pin, state != PCA9552_PIN_STATE_LOW);
> -}
> -
>  static const VMStateDescription pca9552_vmstate = {
>      .name = "PCA9552",
>      .version_id = 0,
> @@ -536,26 +421,92 @@ static void pca9535_reset_hold(Object *obj, ResetType type)
>      s->len = 0;
>  }
>  
> +/*
> + * Get the LSx register as the qom interface should expose the device
> + * state, not the modeled 'input line' behaviour which would come from
> + * reading the INPUTx reg
> + */
> +#define DEFINE_LED_ACCESSORS(n)                                              \
> +static int prop_get_led##n(Object *obj, Error **errp)                        \
> +{                                                                            \
> +    PCA955xState *s = PCA955X(obj);                                          \
> +    uint8_t reg = PCA9552_LS0 + (n) / 4;                                     \
> +    return (pca955x_read(s, reg) >> (((n) % 4) * 2)) & 0x3;                  \
> +}                                                                            \
> +static void prop_set_led##n(Object *obj, int val, Error **errp)              \
> +{                                                                            \
> +    PCA955xState *s = PCA955X(obj);                                          \
> +    uint8_t reg = PCA9552_LS0 + (n) / 4;                                     \
> +    uint8_t old = pca955x_read(s, reg);                                      \
> +    pca955x_write(s, reg, pca955x_ledsel(old, (n) % 4, val));                \
> +}
> +
> +QEMU_REPEAT(PCA955X_PIN_COUNT_MAX, DEFINE_LED_ACCESSORS)
> +
> +#define LED_ENUM_PROP(n) {                                              \
> +    .name = "led" #n,                                                   \
> +    .default_value = -1,                                                \
> +    .qapi_type = &Pca9552LedState_type_info,                            \
> +    .get = prop_get_led##n,                                             \
> +    .set = prop_set_led##n,                                             \
> +},
> +
> +static const QapiEnumProp led_enum_props[] = {
> +    QEMU_REPEAT(PCA955X_PIN_COUNT_MAX, LED_ENUM_PROP)
> +};
> +
> +/*
> + * Report the raw pin logic level; polarity inversion is a read-time
> + * transform applied to the INPUT register, not to the pin state
> + * itself.
> + */
> +#define DEFINE_PIN_ACCESSORS(n)                                              \
> +static int prop_get_pin##n(Object *obj, Error **errp)                        \
> +{                                                                            \
> +    PCA955xState *s = PCA955X(obj);                                          \
> +    uint8_t input_reg = PCA9535_INPUT0 + (n) / 8;                            \
> +    return (s->regs[input_reg] >> ((n) % 8)) & 0x1;                          \
> +}                                                                            \
> +static void prop_set_pin##n(Object *obj, int val, Error **errp)              \
> +{                                                                            \
> +    PCA955xState *s = PCA955X(obj);                                          \
> +    uint8_t config_reg = PCA9535_CONFIG0 + (n) / 8;                          \
> +    /* Only input-configured pins can be driven by an external device */     \
> +    if (!((s->regs[config_reg] >> ((n) % 8)) & 0x1)) {                       \
> +        qemu_log_mask(LOG_UNIMP,                                             \
> +                      "%s: pin %d configured as output, ignoring set\n",     \
> +                      s->description, (n));                                  \
> +        return;                                                              \
> +    }                                                                        \
> +    pca955x_set_ext_state(s, (n), val != PCA9552_PIN_STATE_LOW);             \
> +}
> +
> +QEMU_REPEAT(PCA955X_PIN_COUNT_MAX, DEFINE_PIN_ACCESSORS)
> +
> +#define PIN_ENUM_PROP(n) {                                              \
> +    .name = "pin" #n,                                                   \
> +    .default_value = -1,                                                \
> +    .qapi_type = &Pca9552PinState_type_info,                            \
> +    .get = prop_get_pin##n,                                             \
> +    .set = prop_set_pin##n,                                             \
> +},
> +
> +static const QapiEnumProp pin_enum_props[] = {
> +    QEMU_REPEAT(PCA955X_PIN_COUNT_MAX, PIN_ENUM_PROP)
> +};
> +
>  static void pca955x_initfn(Object *obj)
>  {
>      PCA955xClass *k = PCA955X_GET_CLASS(obj);
>  
>      assert(k->pin_count <= PCA955X_PIN_COUNT_MAX);
> +    /* TODO: use array/list instead of individual QAPI enum properties */
>      for (int ix = 0; ix < k->pin_count; ix++) {
> -        char *name;
> -
>          if (k->has_led_support) {
> -            /* LED variant: expose the LED selector state as led%d. */
> -            name = g_strdup_printf("led%d", ix);
> -            object_property_add(obj, name, "Pca9552LedState",
> -                                pca955x_get_led, pca955x_set_led, NULL, NULL);
> +            object_property_add_qapi_enum(obj, &led_enum_props[ix]);
>          } else {
> -            /* GPIO variant: expose the pin logic level as pin%d. */
> -            name = g_strdup_printf("pin%d", ix);
> -            object_property_add(obj, name, "Pca9552PinState",
> -                                pca955x_get_pin, pca955x_set_pin, NULL, NULL);
> +            object_property_add_qapi_enum(obj, &pin_enum_props[ix]);
>          }
> -        g_free(name);
>      }
>  }
>  
> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
> index e4eddc829ef7..f2a5b94a36d8 100644
> --- a/hw/gpio/pca9554.c
> +++ b/hw/gpio/pca9554.c
> @@ -18,7 +18,7 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-types-machine.h"
>  #include "qapi/qapi-visit-machine.h"

Do you still need qapi/qapi-visit-machine.h?


> -#include "qapi/visitor.h"
> +#include "qapi/qapi-type-infos-machine.h"
>  #include "trace.h"
>  #include "qom/object.h"
>  
> @@ -151,83 +151,60 @@ static void pca9554_set_ext_state(PCA9554State *s, int pin, int level)
>      }
>  }
>  
> -static void pca9554_get_pin(Object *obj, Visitor *v, const char *name,
> -                            void *opaque, Error **errp)
> -{
> -    PCA9554State *s = PCA9554(obj);
> -    int pin, rc;
> -    Pca9554PinState state;
> -
> -    rc = sscanf(name, "pin%2d", &pin);
> -    if (rc != 1) {
> -        error_setg(errp, "%s: error reading %s", __func__, name);
> -        return;
> -    }
> -    if (pin < 0 || pin >= PCA9554_GET_CLASS(s)->pin_count) {
> -        error_setg(errp, "%s invalid pin %s", __func__, name);
> -        return;
> -    }
> -
> -    /*
> -     * Report the physical pin level. The input register is kept in sync by
> -     * pca9554_update_pin_input(): output pins mirror the OUTPUT register and
> -     * input pins reflect the externally driven (or pulled-up) level, so it
> -     * holds the wire level regardless of the configured direction.
> -     */
> -    state = (s->regs[PCA9554_INPUT] >> pin) & 0x1;
> -    visit_type_Pca9554PinState(v, name, &state, errp);
> +/*
> + * Report the physical pin level. The input register is kept in sync
> + * by pca9554_update_pin_input(): output pins mirror the OUTPUT
> + * register and input pins reflect the externally driven (or
> + * pulled-up) level, so it holds the wire level regardless of the
> + * configured direction.
> + */
> +#define DEFINE_PIN_ACCESSORS(n)                                              \
> +static int prop_get_pin##n(Object *obj, Error **errp)                        \
> +{                                                                            \
> +    PCA9554State *s = PCA9554(obj);                                          \
> +    return (s->regs[PCA9554_INPUT] >> (n)) & 0x1;                            \
> +}                                                                            \
> +static void prop_set_pin##n(Object *obj, int val, Error **errp)              \
> +{                                                                            \
> +    PCA9554State *s = PCA9554(obj);                                          \
> +    if (s->hw_dir) {                                                         \
> +        if (!((s->regs[PCA9554_CONFIG] >> (n)) & 0x1)) {                     \
> +            qemu_log_mask(LOG_UNIMP,                                         \
> +                          "%s: pin %d configured as output,"                 \
> +                          " ignoring set\n",                                 \
> +                          s->description, (n));                              \
> +            return;                                                          \
> +        }                                                                    \
> +        pca9554_set_ext_state(s, (n), val != PCA9554_PIN_STATE_LOW);         \
> +    } else {                                                                 \
> +        /* Legacy behavior: force output mode and drive */                   \
> +        uint8_t mask = 0x1 << (n);                                           \
> +        int v = pca9554_read(s, PCA9554_OUTPUT);                             \
> +        if (val == PCA9554_PIN_STATE_LOW) {                                  \
> +            v &= ~mask;                                                      \
> +        } else {                                                             \
> +            v |= mask;                                                       \
> +        }                                                                    \
> +        pca9554_write(s, PCA9554_OUTPUT, v);                                 \
> +        v = pca9554_read(s, PCA9554_CONFIG);                                 \
> +        v &= ~mask;                                                          \
> +        pca9554_write(s, PCA9554_CONFIG, v);                                 \
> +    }                                                                        \
>  }
>  
> -static void pca9554_set_pin(Object *obj, Visitor *v, const char *name,
> -                            void *opaque, Error **errp)
> -{
> -    PCA9554State *s = PCA9554(obj);
> -    int pin, rc, val;
> -    uint8_t mask;
> -    Pca9554PinState state;
> +QEMU_REPEAT(PCA9554_PIN_COUNT, DEFINE_PIN_ACCESSORS)
>  
> -    if (!visit_type_Pca9554PinState(v, name, &state, errp)) {
> -        return;
> -    }
> -    rc = sscanf(name, "pin%2d", &pin);
> -    if (rc != 1) {
> -        error_setg(errp, "%s: error reading %s", __func__, name);
> -        return;
> -    }
> -    if (pin < 0 || pin >= PCA9554_GET_CLASS(s)->pin_count) {
> -        error_setg(errp, "%s invalid pin %s", __func__, name);
> -        return;
> -    }
> +#define PIN_ENUM_PROP(n) {                                              \
> +    .name = "pin" #n,                                                   \
> +    .default_value = -1,                                                \
> +    .qapi_type = &Pca9554PinState_type_info,                            \
> +    .get = prop_get_pin##n,                                             \
> +    .set = prop_set_pin##n,                                             \
> +},
>  
> -    if (s->hw_dir) {
> -        /* Warn and ignore if the guest has configured this pin as output */
> -        if (!((s->regs[PCA9554_CONFIG] >> pin) & 0x1)) {
> -            qemu_log_mask(LOG_UNIMP,
> -                          "%s: pin %d is configured as output, "
> -                          "ignoring external set\n",
> -                          s->description, pin);
> -            return;
> -        }
> -        /* Drive the external input level */
> -        pca9554_set_ext_state(s, pin, state != PCA9554_PIN_STATE_LOW);
> -    } else {
> -        /* Legacy behavior: force output mode and drive */
> -        /* First, modify the output register bit */
> -        val = pca9554_read(s, PCA9554_OUTPUT);
> -        mask = 0x1 << pin;
> -        if (state == PCA9554_PIN_STATE_LOW) {
> -            val &= ~(mask);
> -        } else {
> -            val |= mask;
> -        }
> -        pca9554_write(s, PCA9554_OUTPUT, val);
> -
> -        /* Then, clear the config register bit for output mode */
> -        val = pca9554_read(s, PCA9554_CONFIG);
> -        val &= ~mask;
> -        pca9554_write(s, PCA9554_CONFIG, val);
> -    }
> -}
> +static const QapiEnumProp pin_enum_props[] = {
> +    QEMU_REPEAT(PCA9554_PIN_COUNT, PIN_ENUM_PROP)
> +};
>  
>  static const VMStateDescription pca9554_vmstate = {
>      .name = "PCA9554",
> @@ -264,16 +241,9 @@ static void pca9554_reset(DeviceState *dev)
>  static void pca9554_initfn(Object *obj)
>  {
>      PCA9554Class *pc = PCA9554_GET_CLASS(obj);
> -    int pin;
>  
> -    for (pin = 0; pin < pc->pin_count; pin++) {
> -        char *name;
> -
> -        name = g_strdup_printf("pin%d", pin);
> -        object_property_add(obj, name, "Pca9554PinState",
> -                            pca9554_get_pin, pca9554_set_pin,
> -                            NULL, NULL);
> -        g_free(name);

Should we have the same TODO comment here as with the 9552 code?

Thanks,

Glenn

> +    for (int pin = 0; pin < pc->pin_count; pin++) {
> +        object_property_add_qapi_enum(obj, &pin_enum_props[pin]);
>      }
>  }
>  
> 

