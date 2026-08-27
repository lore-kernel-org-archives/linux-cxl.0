Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867373ED5BB
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820044; cv=none; b=VZi7IMgPGMfVwI/weQwGLJDpVR6yUXv9DksheRhuKBU75TXl67BcPGIx5vsV6ErW5ynlSDX1DLUtfPNj/OhpM9AnBYz3WGYETXqTEHKSM5QvSe+tKJde7p7/x3BATt8bvbeJZKsCsZ+oUDUjZ2cSl3IojbPGo+vl2gay4B+rPHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820044; c=relaxed/simple;
	bh=IWQCMpgH0UqwOxmmLqdCAD8aNqh44/YZVGmCR+0vHOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=chJi8dHjxFXNyA7IxJKOl9oxquitrpuZ/V27wJayRgU6i+u8lAquIXezbG1GoBuJbAbbuz0ZDeglxQb3UiztY0Lfmk3L68PIBPLYhLrQJwNYumLf29zzpii7h07Wi9yrBfg6TjW7qFt1ZY7IQSG/Ecefjok5G2pK+zzZKDE3oyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IUs4rwdi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QjjBYA6/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IUs4rwdi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QjjBYA6/"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R6R6FK3269801
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 08:40:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sQ50trFlPo5d532JdYVenY8HaFTmYzIbecwPOKivr/U=; b=IUs4rwdim/Mea8RA
	SzmrAM2qg09ynuk0KJGhht84Qgasz1eMrZkTPTIhpc6GuIToUs1k1WqPVHTxbkpC
	dngq8rn4zGlFI194CaK/rjItk/wN0JrqY8XrkNtb0ySr4yIxGdt8HCXf7gP7XSMB
	c7VqOrPISlcHMM5W0LUNvw2Zn0TsEfQlU0qallQTlktxdh4z4GxJdifkub/HgMl7
	ekeUCEu6qblZEVHvzmN0VQ30cuIiZFR+W9pDlvTAbzw0guSwn8FMbTE9fFa1fLbZ
	hZDYsX5t+/9Z0nQlSttF/gss8gmjdJ/metK32FMJm8e+64Lz9ykaTdXC4rHRJl0N
	2f1NCw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga075c2uh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 08:40:39 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52f9e903b02so5274431cf.0
        for <linux-cxl@vger.kernel.org>; Thu, 27 Aug 2026 01:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787820039; x=1788424839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sQ50trFlPo5d532JdYVenY8HaFTmYzIbecwPOKivr/U=;
        b=QjjBYA6/XEh2eO4njhzWImvvhb3XshBeF5B9Ker9hyj3rFUkMM2qnXemMbB9W5pra1
         GY4syaYzEkPKeZz75t3qIuWfa0g4336t5v4NNYPjzkSXAHrfCBsq/SNwsBqmZZ3Ffsdj
         2ClNp/np6Ed/oe0M6BiwGvuvYinLTKhuNEG42WiN0twwNQ5IIw4bJkuxwphDN3pZq+rC
         CHh6q96qYJV03lILQs8EkM4TrCyg0SBZ3pvlfGTpIEhKtdCDL5zxFXFmqMZ5AUbWtqTn
         z4mjY71ywp1CFmWcgnVDjzMV7mebnMcj2zPvcIMGgaGHmZ5wOCIR3PafT6+odYxr7+Cg
         pJOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787820039; x=1788424839;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sQ50trFlPo5d532JdYVenY8HaFTmYzIbecwPOKivr/U=;
        b=nSwVlh40f1z3GUAlst0/GIJmYyGEXX2DnuU+PZKJ4sWKPkx43Ig4AfN3TD6dkjs9NQ
         LXCnaAgWY0HGgUlP7uPm5zXOY97IJ8TVJk3BvZ+ZZT3gyN3A0Fs+4HTaCJqmJDfA8w6K
         fNIeW+pQDsb15Gb896a1a07WsUZeaEan8OHx0nxIIa3AwHu8BEPHEO1ATOHKKSuIfJRj
         zzzz8gDTIxhwBD64k0IJWICX9TA/COLsdwLwVCuup5JLss2SFS2o2q/y4+mjgiztDSV1
         1NeuVu943yeOJ/mZtAw/uRS84n+7MqM+fzzWovFiNJvmVytko+Z4GNlUn3b4cSN3Pk9Y
         JW0Q==
X-Forwarded-Encrypted: i=1; AHgh+RqnUXx/6AZD0jzNgdFiDh4AfsocOTbjTf6RsJ5EnhOQ5M66vBKqJSqV+xJTp4cJR57LVgmoaGQSlqo=@vger.kernel.org
X-Gm-Message-State: AFuF++myEe47PAsmv380+qzEX7WHMzYfidRe1TRaTPsxdxhBZ5dpwUvo
	CM1VQjzgcyI3P3nqbUlLbYkI3mFwC10RUXRVdrPUhz8rqV6PbVsn6a3Ra2K87IpHzJp+jwdeMym
	hsa74i5/4UQXfnprGOh0h6Ixtc1dYpwgTcCDNXDU4iKAXCTpkJVGXeS7KWPg9sTE=
X-Gm-Gg: AR+sD11brrinIyztK0YVj1Ct3brP6n0WhqfSJRBp6Z194BNHwjkcTI4/rozx8AeOf2C
	r10VHsMVlow+5sSjxo4GsSby3DRhLYA+n2tABNbiFNR5nhCYN73NIkJGNaP18j1yYbzk5YYTCbi
	tNfANJGGRIsTkaAGEEGK7KunkXCGs06tFMr5nouHRNpav9i+1WORXvb0cKId4uQvluvKY+4xHq9
	Wm+mdVjY1J/Ue2naIxjwzhpbKmIbyrfAIxSvBPz/sXllQ6ezg1nNvha/uM4VqF8HcK3vD1N4pAV
	vIZJJ8Ea+xODy8IONdWCiAxTo6zDTW35LbEcxI8hTfarSJOMCF4OJVNQC2VmGfZ4zoiNAI5uotl
	6Wgfe9+XtpF07BzQvXq5EZPB2S47Z1kp64ygv0Zngu4wkZ5ii
X-Received: by 2002:ac8:5950:0:b0:51b:fcc1:a0b7 with SMTP id d75a77b69052e-52fa1a99ecfmr41469281cf.8.1787820038724;
        Thu, 27 Aug 2026 01:40:38 -0700 (PDT)
X-Received: by 2002:ac8:5950:0:b0:51b:fcc1:a0b7 with SMTP id d75a77b69052e-52fa1a99ecfmr41468881cf.8.1787820038289;
        Thu, 27 Aug 2026 01:40:38 -0700 (PDT)
Received: from [10.254.188.74] (164.170.88.92.rev.sfr.net. [92.88.170.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e28dc0d6sm7964052f8f.18.2026.08.27.01.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 01:40:37 -0700 (PDT)
Message-ID: <b62f7ab6-80d5-4e2d-b253-db6c1b5758b4@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 10:40:30 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/43] qapi: convert trivial intro sections for
 pci.json
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        linux-cxl@vger.kernel.org, Markus Armbruster <armbru@redhat.com>,
        Michael Tokarev <mjt@tls.msk.ru>,
        Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
        Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
        =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        zhenwei pi <zhenwei.pi@linux.dev>, qemu-trivial@nongnu.org,
        Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
        Laurent Vivier <laurent@vivier.eu>, Jiri Pirko <jiri@resnulli.us>,
        qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>, linux-edac@vger.kernel.org,
        "Gonglei (Arei)" <arei.gonglei@huawei.com>,
        Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
        Zhao Liu <zhao1.liu@intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
        Jason Wang <jasowangio@gmail.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Lukas Straub <lukasstraub2@web.de>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
 <20260826193840.2152000-26-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826193840.2152000-26-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: HmBfb8vB5xQXeKLCqFMfvIFe-BuwYPzN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3MCBTYWx0ZWRfX2M3QFC9ZEbC3
 blOwbZiWvgDRkWX5fQvqgM44QdSjJAaqFo5e0i91I9lamjOeSftJOnaFNLrFlVPnNqTJnSnpPue
 zvQhQEFPGqpG+K0m0AXbtsZb3pk267N78x8+dCTScXGAhviIbPEo8ArkTTYC20/EvxT3Fd9ENXg
 0f5CnSFlqZcwtdfEkWpfrZ6jATteUca2Imyesdm8rHfaS9+PHonPEyPHfDlEGNXMHmiYLRT6woN
 5QY47w/TI5bkLp9QpfMX99WdhJUjnMBRXnm/Py7zs5Z2G9kAICFITs0ry6+8SyG5puY2FpvBGh7
 3tQiJgFko88vvhwJL9vrHYExisfUuJZweWU2W+UUF0K75IY6EV/A539BofEZvcRWU88i1p90g8C
 4cPC36c6tUqvKeOkvJCVbL2w4K8OzybQsT69tmBv4QYU8bMgTVTWsFd0CsKsLuzP3mCpBMLFBZf
 Fpzua4CL0pafxe8qxxg==
X-Proofpoint-GUID: HmBfb8vB5xQXeKLCqFMfvIFe-BuwYPzN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3MCBTYWx0ZWRfX0PTp5AEiJvHW
 S9yHyr3KmM/9OYxVVMhOIqoBoaOxvHv40JP6z7BBtgt1k+EDcmRCK6gOZFNv6jeyyqabjWVE4Mk
 OT2FqD5VlR0pvawheuhoiyiLj/vIcGs=
X-Authority-Analysis: v=2.4 cv=RPiD2Yi+ c=1 sm=1 tr=0 ts=6a8ff807 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=T/Q9W4kDmp1FI4VDxy1skw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=UFf3ptpOQOAA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270070

On 26/8/26 21:38, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   qapi/pci.json | 27 +++++++++------------------
>   1 file changed, 9 insertions(+), 18 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
