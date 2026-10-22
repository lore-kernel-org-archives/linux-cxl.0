Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792657829;
	b=voCUaYoUri2iz9kGzjYJ0dYjKNJAq+qNp01jbefw8o63wrWrOwkDgtw2ZcK+7RYjNoPM
	 43qNW7Uqwwgq42aTKG+03K/qZ6Wc4Qqp08a2SkS5l7JyjNbWdrcKAF1aCalbXue7b53IG
	 H6t0EkT9GAsev9ulRBLQEKBZ2/NOxUpEb4xpZhGTz1vCP7rqG81kv8tRVU7YSVRg/hWL5
	 SvcLhQAX4Osz4PKgL024n02AhclTDCkfaSjxgnb6SXxO0ETZusov/szcZloh8Xbc6SUsz
	 dcnluBBUObNkySHrUkvtKKjjjLD/0CUll5aEK4pTz7RkCbjWSD6wrOYW9dDl0MsoAvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657829;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:In-Reply-To:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding;
	bh=xexW0rNqv/GKFX03e5NGVfizRBWHHld9j1Z0S71dlRQ=;
	b=uKZpV0qg0bIB2EWW4Ay0oGSPi9IuPE/vAS45PoQ7sUo8yu5QJXSQJXymxW1XMiFErSkx
	 zJ1xjjM5Mg2qvh3yAe53cY2BJOzdQmANrohwPQDrtAhmbXPDxPxCHqu8nuOh0EakGARxS
	 DIbxWm9yYLL3b9i2srz31XRAkQyo2Un0kmllS9MPHV1WS01Uf/jLb75S+PjIvKTisKpJe
	 GFLg9ma3pupTsZGIKHS1Rxs5CwdwBLad1aMPJjz8dEZsN/7jl7fGN1CrKJ6xc57r6nlks
	 CjernLjdqywxR/2+loaDKDczFarSmuzjH2to1RdH//4R4NR2j/JZGHQTtrjMKp0z7Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hwN1qIcP;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660E3606A31D
	for <linux-cxl@vger.kernel.org>; Thu, 22 Oct 2026 08:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 660E3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hwN1qIcP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792657828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xexW0rNqv/GKFX03e5NGVfizRBWHHld9j1Z0S71dlRQ=;
	b=hwN1qIcPWU5jWq8MyXfzVNIfGA98dEKzvCXxRHXAz8/yVgm8UldjqNQ1hUfvB9BposHJW2
	K32k8NiOlOsyU61ykUhdhzSzF5AXsolm9S0dyPUyyb/D0go3SNnIBfBt8JixBNcJmaBI9n
	QZv95T0B3AH3xWsXCncaUnjC76bDZxI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-7m63-_WdN--ms9gOad-qrg-1; Thu,
 22 Oct 2026 04:30:24 -0400
X-MC-Unique: 7m63-_WdN--ms9gOad-qrg-1
X-Mimecast-MFC-AGG-ID: 7m63-_WdN--ms9gOad-qrg_1792657820
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C984180060C;
	Thu, 22 Oct 2026 08:30:18 +0000 (UTC)
Received: from jtomko.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC8EA1956088;
	Thu, 22 Oct 2026 08:29:49 +0000 (UTC)
Date: Thu, 22 Oct 2026 10:29:47 +0200
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: devel@lists.libvirt.org, marcandre.lureau@redhat.com,
	qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
	John Snow <jsnow@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Kostiantyn Kostiuk <kkostiuk@redhat.com>,
	Eric Blake <eblake@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Igor Mammedov <imammedo@redhat.com>,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
	Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
	Hanna Reitz <hreitz@redhat.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
	Zhao Liu <zhao1.liu@intel.com>, Jonathan Cameron <jic23@kernel.org>,
	Junjie Cao <junjie.cao@intel.com>, Anisa Su <anisa.su@samsung.com>,
	Elena Ufimtseva <elena.ufimtseva@oracle.com>,
	Jagannathan Raman <jag.raman@oracle.com>,
	John Levon <john.levon@nutanix.com>,
	Thanos Makatos <thanos.makatos@nutanix.com>,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>, qemu-block@nongnu.org,
	linux-cxl@vger.kernel.org, qemu-s390x@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sergio Lopez <slp@redhat.com>, qemu-arm@nongnu.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alistair Francis <alistair.francis@wdc.com>,
	Weiwei Li <liwei1518@gmail.com>,
	Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
	Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>,
	Xianglai Li <lixianglai@loongson.cn>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Pedro Barbuda <pbarbuda@microsoft.com>,
	Mohamed Mediouni <mohamed@unpredictable.fr>,
	Nicholas Piggin <npiggin@gmail.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Amit Machhiwal <amachhiw@linux.ibm.com>, qemu-ppc@nongnu.org,
	Zhang Chen <zhangckid@gmail.com>,
	Li Zhijian <lizhijian@fujitsu.com>,
	Alistair Francis <alistair@alistair23.me>,
	Alexander Graf <graf@amazon.com>,
	"Gonglei (Arei)" <arei.gonglei@huawei.com>,
	zhenwei pi <zhenwei.pi@linux.dev>, Ani Sinha <anisinha@redhat.com>,
	Luc Michel <luc@lmichel.fr>,
	=?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
	Jamin Lin <jamin_lin@aspeedtech.com>,
	Kane Chen <kane_chen@aspeedtech.com>,
	Samuel Tardieu <sam@rfc1149.net>, "Denis V. Lunev" <den@openvz.org>,
	FangSheng Huang <FangSheng.Huang@amd.com>,
	Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
	Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
	Jesper Devantier <foss@defmacro.it>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Glenn Miles <milesg@linux.ibm.com>, Conor Dooley <conor@kernel.org>,
	Sebastian Huber <sebastian.huber@embedded-brains.de>,
	Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Jason Herne <jjherne@linux.ibm.com>,
	Titus Rwantare <titusr@google.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Anthony PERARD <anthony@xenproject.org>,
	Peter Xu <peterx@redhat.com>, Chinmay Rath <rathc@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	xen-devel@lists.xenproject.org,
	Roman Bolshakov <rbolshakov@ddn.com>,
	Phil Dennis-Jordan <phil@philjordan.eu>, Fam Zheng <fam@euphon.net>,
	Farhan Ali <alifm@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Tao Tang <tangtao1634@phytium.com.cn>,
	Fabiano Rosas <farosas@suse.de>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Yoshinori Sato <yoshinori.sato@nifty.com>,
	Jiri Pirko <jiri@resnulli.us>, Eric Auger <eric.auger@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>
Subject: Re: Property types changed in this series
Message-ID: <atnJe88B09dFcDr2@jtomko.csb>
References: <20261020-qom-qapi-v7-0-431a86b02b58@redhat.com>
 <87tsmfkoej.fsf@pond.sub.org>
 <878q3qkz6f.fsf@pond.sub.org>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <878q3qkz6f.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: ocDkPUWRe9qRnJkjCNsDpAaFeFatRzSf0GbV7KuNMYM_1792657820
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On a Thursday in 2026, Markus Armbruster via Devel wrote:
>Libvirt developers: does libvirt use member @type of the reply of
>qom-list, qom-list-properties, qom-list-get?
>

The code for getting CPU properties uses qom-list-get for new QEMUs,
where it checks whether "type" is "bool".

I think that can be easily converted to just check for the JSON type.

Jano

>I'm asking because Marc-André's work changes many values to add a more
>useful replacement.  I think we should deprecate @type.  I'd like to
>find out whether we need to preserve the values for the deprecation
>grace period.
>

