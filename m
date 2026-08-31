Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A3A58B6B1
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788184233; cv=none; b=b5M8RQFTv703icolE7JROaAxADPE7ae88i/vUAyjftkssyoK48S4JIpq3Y5f7ug7zd1n3apCCWrsaVFcBayy6IOHM1pRcScBFIolqng9qYbfnppBhIKRCsSJ628vZtU6eAXxhUrDs8mo40rJ0KmbdZWww8W7iFsDsQwlo6y3Jd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788184233; c=relaxed/simple;
	bh=fUAZA3B51kBX3IBJdHF3/b4fDkqmat3bwjK2RudQI8s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PsLl5XyAxeosNuGIPyIsY8w68qW5a1gY9blqmw6aN4xXukcXnn+mMBpDGdHrzrCtyNrisxlqHwipBBX3Cn2buAWnHJYRnNeTZky8XxEANjEDQCbLCxlGJKT9PJlCNeRNpZyf8McKLQEFEldgO0cLWT+qz9j1LNQvbSuNBQnK3hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UdgWklD0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UdgWklD0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788184229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zoTZvmy4jPUbkp6P4GsXHnJjsEPvOhs/+ivdjF0DsTM=;
	b=UdgWklD0OYV/9BPciAIvbEwz0glE9+NoNWnw1p9bFNwMKWbjXXd73T14Q3su6wgnMsnLe5
	KzBns9kjn+RUNiF3V5kDIAcfytY3yNzKYW+NhUAQujvMLCqkfACJokg7AA54f5gBz4YPIM
	YwuOYBmXZgiAfN90Nj3xXBPGEjU87sY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-vkSRe0j1MoqBXm7keiMN6Q-1; Mon,
 31 Aug 2026 09:50:24 -0400
X-MC-Unique: vkSRe0j1MoqBXm7keiMN6Q-1
X-Mimecast-MFC-AGG-ID: vkSRe0j1MoqBXm7keiMN6Q_1788184220
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 57535195DE5B;
	Mon, 31 Aug 2026 13:50:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 750891956042;
	Mon, 31 Aug 2026 13:50:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id F002421E6837; Mon, 31 Aug 2026 15:50:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Alex Williamson <alex@shazbot.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
  linux-cxl@vger.kernel.org,  Michael
 Tokarev <mjt@tls.msk.ru>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Peter Xu <peterx@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
  zhenwei pi <zhenwei.pi@linux.dev>,  qemu-trivial@nongnu.org,  Fabiano
 Rosas <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Laurent Vivier
 <laurent@vivier.eu>,  Jiri Pirko <jiri@resnulli.us>,
  qemu-block@nongnu.org,  Stefan Hajnoczi <stefanha@redhat.com>,  Stefan
 Berger <stefanb@linux.vnet.ibm.com>,  linux-edac@vger.kernel.org,
  "Gonglei (Arei)" <arei.gonglei@huawei.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,  Jonathan
 Cameron <jic23@kernel.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Zhao
 Liu <zhao1.liu@intel.com>,  Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
  Hanna Reitz <hreitz@redhat.com>,  Jason Wang <jasowangio@gmail.com>,
  Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Lukas Straub
 <lukasstraub2@web.de>,
  =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v3 42/43] qapi: convert trivial intro sections for
 machine.json
In-Reply-To: <87pkyye7j1.fsf@pond.sub.org> (Markus Armbruster's message of
	"Mon, 31 Aug 2026 15:36:34 +0200")
References: <20260826193840.2152000-1-jsnow@redhat.com>
	<20260826193840.2152000-43-jsnow@redhat.com>
	<87pkyye7j1.fsf@pond.sub.org>
Date: Mon, 31 Aug 2026 15:50:13 +0200
Message-ID: <87ecfee6wa.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: qtL58sArVWGlD7YF4GuX-uiTL4RIhnCS2OXNuioC1jg_1788184220
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Markus Armbruster <armbru@redhat.com> writes:

> John Snow <jsnow@redhat.com> writes:
>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  qapi/machine.json | 208 ++++++++++++++++------------------------------
>>  1 file changed, 73 insertions(+), 135 deletions(-)
>>
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index 2d63c1bac3b..3a5c6df9cff 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>
> [...]
>
>> @@ -469,8 +453,7 @@
>>  
>>  ##
>>  # @NumaOptions:
>> -#
>> -# A discriminated record of NUMA options.  (for OptsVisitor)
>> +#     A discriminated record of NUMA options.  (for OptsVisitor)
>>  #
>>  # @type: NUMA option type
>>  #
>
> The parenthesis is questionable.  As long as it's there, this isn't
> "very trivial".

Could move it into the sentence, like so

    # A discriminated record of NUMA options (for OptsVisitor).

But I think we can just drop it.

Neither should be in the "very trivial" jumbo patch.

>> @@ -488,8 +471,7 @@
>>  
>>  ##
>>  # @NumaNodeOptions:
>> -#
>> -# Create a guest NUMA node.  (for OptsVisitor)
>> +#     Create a guest NUMA node.  (for OptsVisitor)
>>  #
>>  # @nodeid: NUMA node ID (increase by 1 from 0 if omitted)
>>  #
>
> Likewise.

[...]

